From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] refs.c: add a function to append a reflog entry to a
 fd
Date: Thu, 20 Nov 2014 13:31:55 -0800
Message-ID: <20141120213155.GK6527@google.com>
References: <20141120023655.GG6527@google.com>
 <1416508657-9057-1-git-send-email-sbeller@google.com>
 <20141120212022.GJ6527@google.com>
 <CAGZ79kZDMWyW46wNgqudPiX1UmZteyFVJXMAYqJpp8e_r8LCmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 22:31:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrZKX-0001eO-Lq
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 22:31:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758265AbaKTVbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 16:31:52 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:46971 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758261AbaKTVbv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 16:31:51 -0500
Received: by mail-ig0-f178.google.com with SMTP id hl2so3589453igb.17
        for <git@vger.kernel.org>; Thu, 20 Nov 2014 13:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=31ocndeTHDSDtntqofaSCUARrIdT743Jn0RUIkChKek=;
        b=SO+jNdvfNwCEKwY82TNge8Bn5cVW9BZ/SkQfjOn+iiGES83Dz2xsCFM4D10DWqf1i6
         q0kHu0bS9OJANUvp4VKddTeeJ1Pv2FcxHhniTh2Sy/icFQKNcPRST2YAWH76EX2Ww82R
         Acg32VEU/Is1Gmc0hjFCNhqCbB7iOlBbh/fmeLDZT0c1EItmMj+p36mOMTJ7/FP1gqn4
         fLU3fQtYgH7UDMQeSXQawC4Bf7BLYxumcykKuW8Dt2+L9iiGNAgQCzw3UjD+6jmL0LIP
         xdjQsFCQK2UitsKryFXZ5omxlAExawkZ3rf5KCHwbEDlhkPu5hqli0DEo8DmKqRed5dk
         o+MQ==
X-Received: by 10.50.109.133 with SMTP id hs5mr209087igb.15.1416519110804;
        Thu, 20 Nov 2014 13:31:50 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:31da:72d3:8c17:80bd])
        by mx.google.com with ESMTPSA id xb4sm2132717igc.11.2014.11.20.13.31.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Nov 2014 13:31:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGZ79kZDMWyW46wNgqudPiX1UmZteyFVJXMAYqJpp8e_r8LCmQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:
> On Thu, Nov 20, 2014 at 1:20 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> I don't understand why the above writes to a temporary variable and
>> checks it, never to read that temporary again.
>>
>> I don't think that alone is a reason to block the patch, but it
>> worries me in that the review comment seems to have been just lost.
>
> It wasn't lost as I think it should go in a follow up patch. Sorry for
> not stating that clearly.
> (This patch is about moving code around, not changing code)

Ah, sorry for the lack of clarity.

I agree completely with the above principle.  But the code that writes
to result and checks result is new code, not part of the code that
moved.
