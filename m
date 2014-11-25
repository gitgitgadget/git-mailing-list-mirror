From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 0/2] git-am: add --message-id/--no-message-id options
Date: Tue, 25 Nov 2014 20:16:18 +0100
Message-ID: <5474D582.9060604@gnu.org>
References: <1416924056-29993-1-git-send-email-bonzini@gnu.org> <xmqqwq6jruyd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 20:16:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtLbD-0002Dh-PO
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 20:16:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbaKYTQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 14:16:25 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33550 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbaKYTQX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 14:16:23 -0500
Received: by mail-wi0-f174.google.com with SMTP id h11so10207246wiw.7
        for <git@vger.kernel.org>; Tue, 25 Nov 2014 11:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=IRoInkxDJIsj5XIlIwPXHfwY1Yv9I4wWShkboFQWctU=;
        b=TkD2rjnIvF3ZCm62/vdU8cZ+IKjIpdFdkmajz80D/HLS1YsmHW8WyDywj0Jc3Gfer1
         Lw8sUJ2uzbZK0p85iW/thbaa+Br/cMOgEIdVawKL3+FbfShsPblU8PIPb6yrqI2vmERr
         WbNeLD5is+0T8elzMbutXPfIGs6XyNDnbi9suuFrsSghLYuLl0US3Wjx7/NL0uHGmQiJ
         lWF1ulTSk/crJl0WeptzFN3aE1Mwpx9wuKzn2SZ1Tf8HaR5O1KszegXC17rolUDV/gxE
         Ip1mDHYbvQFt2e2Z+OZvVX3t7rN7vI8KHoTMbSapTVlRBEkSnZVioY0evs8S+KvhaK6y
         dmQA==
X-Received: by 10.180.10.231 with SMTP id l7mr8654710wib.1.1416942981978;
        Tue, 25 Nov 2014 11:16:21 -0800 (PST)
Received: from [192.168.10.165] (net-93-146-133-240.cust.vodafonedsl.it. [93.146.133.240])
        by mx.google.com with ESMTPSA id td9sm4058606wic.15.2014.11.25.11.16.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Nov 2014 11:16:20 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <xmqqwq6jruyd.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260236>



On 25/11/2014 19:33, Junio C Hamano wrote:
>> > If both --message-id and -s are specified, the Signed-off-by goes
>> > last.  This is coming out more or less naturally out of the git-am
>> > implementation, but is also tested in t4150-am.sh.
> Nice.  So if you apply a message whose last sign-off is yourself
> with both of these options, what would we see?
> 
>     1. S-o-b: you and then M-id: and then another S-o-b: you?
>     2. M-id: and then S-o-b: you?
>     3. S-o-b: you and then M-id:?
> 
> I do not offhand know which one of the above possibilities to favor
> more over others myself.  Just asking to find out more about the
> thinking behind the design.

You currently get (1), which is arguably the most precise but definitely
the ugliest.

In this case (posting as maintainer), I would probably not use "git am
--message-id"; instead I would use an alias to add the Message-Id (with
git interpret-trailers!) after posting to the mailing list, resulting in
either (2) or (3).

I think (but I am not sure) that git-am could use a hook to rewrite (1)
into (2) or (3).

Paolo
