From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: Re: [PATCH v2] builtin/receive-pack.c: use parse_options API
Date: Wed, 2 Mar 2016 10:48:11 +0530
Message-ID: <56D67793.5080308@gmail.com>
References: <1456846560-9223-1-git-send-email-tigerkid001@gmail.com>
 <1456846560-9223-1-git-send-email-tigerkid001@gmail.com>
 <1456863661-22783-1-git-send-email-tigerkid001@gmail.com>
 <vpqvb56yltc.fsf@anie.imag.fr> <xmqq4mcp7t28.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Mar 02 06:18:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aazAz-00066P-It
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 06:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbcCBFSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 00:18:17 -0500
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33174 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbcCBFSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 00:18:16 -0500
Received: by mail-pa0-f67.google.com with SMTP id y7so11655870paa.0
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 21:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=R46O3Fu6kQsakWh+/pEMJ8oVRw/JQ+KHa5ziLIL1mPo=;
        b=YLPpDc7w40DB8lvAYESuDQmD52v8WlikMuOsIwviV4wR2DK7Xp21SumUzLIRSxFHt2
         zwzRZ9aORpbxsSALxwNrrqjFYACBkZ4jnjxX4oqGsKRLmg5HVHZWiZ/trKLCwwAJ8tuX
         dW1bUO0sL9j3ObEa5saBFQr4VrK/BqKczOTqrRytMiYDMNJg1f6czDZ35dtyXdQmUg5I
         SOZeJZcuTWHjPyzWvKzIYU7crxjcdwsdoGSGDEUtD9NJkUxip44z0djPPt5MIX7gGb0+
         0tEDufzMV3/6vRJ1wtd9FtQJr7KwS9NdsD/RWyg+TVJj+ouSKWY95MgII7KmMuizCGcU
         z5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=R46O3Fu6kQsakWh+/pEMJ8oVRw/JQ+KHa5ziLIL1mPo=;
        b=XX7+uP4meesevKSBHlqBrznWQkvffR/GlbQG/JLcWa4xPn3UPph+zzt5uRTTufIxoM
         Rkir74jmGmIiT9hSoNUw4DEFLz0yg8mf+eUHK7z8z0N3VJ62YjdUYhUnxYJOPgSYPKmr
         eTUu/wcgWh/5TFUGKlfa766vos/L/6mnFznJg/zfaE51hcBzRNuGNcL6pdO6kmHs9QtA
         2A9MsIGvhqFIm+68Eb4YdJ81PN7Sg7dWQYGX3AcoMnST6JAWysUyiU9s/RHQs+hIEaDc
         T8k9Zq2A7d1i1UL8Cha+ltXhCcDVlOupkvxJn6dyXidKMqXROuMkIviqzNKxKsYdtmza
         Xsew==
X-Gm-Message-State: AD7BkJJVmSBF4o06LGQaPAuD8gSsHQiMxvsLRf7cLRWb3lhY8LzCq7dnyEqhSbpMkeNC0A==
X-Received: by 10.66.191.104 with SMTP id gx8mr35577300pac.21.1456895896004;
        Tue, 01 Mar 2016 21:18:16 -0800 (PST)
Received: from [192.168.1.10] ([182.68.185.50])
        by smtp.gmail.com with ESMTPSA id ey7sm11776625pab.47.2016.03.01.21.18.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Mar 2016 21:18:15 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <xmqq4mcp7t28.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288096>


> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> "Sidhant Sharma [:tk]" <tigerkid001@gmail.com> writes:
>>
>>> Make receive-pack use the parse_options API,
>>> bringing it more in line with send-pack and push.
>> Thanks. This version looks good to me.
> I'll queue this with your "Reviewed-by:" to 'pu', just as a
> Microproject reward ;-).  Given that the program will never see an
> interactive use from a command line, however, I am not sure if it is
> worth actually merging it down thru 'next' to 'master'.
>
> Thanks.

Thanks for accepting my patch :)
Now that this one is complete, I was wondering what should I do next. Is there a list of more such microproject-like projects? I'd be very excited to contribute more patches.


Thanks and regards,
Sidhant Sharma [:tk]
