From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCHv3 2/3] mailmap: use higher level string list functions
Date: Sun, 30 Nov 2014 18:33:14 -0800
Message-ID: <547BD36A.7050806@gmail.com>
References: <CAPig+cQ_4A-0LOgXXG5qLeHOev+g8KMq5osKz34AFijGuyRidQ@mail.gmail.com>	<1416887054-27204-1-git-send-email-sbeller@google.com>	<CAO2U3QjNua2HvJKLnq80mPFEp931yLzHKENKo-LHm4CFZWRhBA@mail.gmail.com>	<CAPig+cRNuuDDBV0-TwANuiv+f_c1mfXp2Q4rF1Sj5mtJoLoqHQ@mail.gmail.com> <xmqq7fyctcur.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Michael Blume <blume.mike@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 03:33:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvGni-0005RI-8q
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 03:33:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631AbaLACdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2014 21:33:18 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:47321 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308AbaLACdS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 21:33:18 -0500
Received: by mail-pd0-f179.google.com with SMTP id w10so9817807pde.24
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 18:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=t+SMhZMThU4ojQd2i904QRjQ0nKJYkRc08Yw1LqnGS0=;
        b=A6VfPo1A9ZcIRT2tPmDMfIjzdL0eo24fOZeU4HLfXMfMESFvsrSSnuPGPwV63rj7VF
         pToYS8duiTJ0Z2M794UYKpcp+04H47jb5Grog5v+CmmnwrXztnKcH8ZkMiAJXMEDyNBJ
         8bWOJ8XNB/gh6VPi3t64QdwAOlILaUeLZgS7RdglGonZwrMhGLNOeb+wVbrXzAJUGXMw
         Ce2O9TlHY0dr6TECpQWEC7UpXdU0M/p5wRl6Ty090+IdCiz0QraIhNRwV1dVq5IuOpQ5
         Ek50NI0fL6CIrWFkWW/y+ASQ9x4tLKD1pMl3NLpKcTpGLxMqeiZi2fKLg65my/+JAhKW
         v25Q==
X-Received: by 10.68.217.231 with SMTP id pb7mr95965208pbc.124.1417401197595;
        Sun, 30 Nov 2014 18:33:17 -0800 (PST)
Received: from [192.168.2.3] (c-76-102-52-132.hsd1.ca.comcast.net. [76.102.52.132])
        by mx.google.com with ESMTPSA id ae4sm16072876pad.16.2014.11.30.18.33.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 18:33:16 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <xmqq7fyctcur.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260461>

On 30.11.2014 16:47, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
>> On Thu, Nov 27, 2014 at 1:44 PM, Michael Blume <blume.mike@gmail.com> wrote:
>>> The variable index seems to be unused/uninitialized now -- it's still
>>> printed in debug messages, but if I'm reading correctly, its contents are
>>> going to be nonsense.
>>
>> Nice catch.
> 
> Let's do something like this squashed in, then.

Michael, thanks for catching that!

Junio, the squash-in looks fine with me.

> 
>  mailmap.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mailmap.c b/mailmap.c
> index 3b00a65..cb26af0 100644
> --- a/mailmap.c
> +++ b/mailmap.c
> @@ -90,8 +90,8 @@ static void add_mapping(struct string_list *map,
>  	}
>  
>  	if (old_name == NULL) {
> -		debug_mm("mailmap: adding (simple) entry for %s at index %d\n",
> -			 old_email, index);
> +		debug_mm("mailmap: adding (simple) entry for '%s'\n", old_email);
> +
>  		/* Replace current name and new email for simple entry */
>  		if (new_name) {
>  			free(me->name);
> @@ -103,8 +103,7 @@ static void add_mapping(struct string_list *map,
>  		}
>  	} else {
>  		struct mailmap_info *mi = xcalloc(1, sizeof(struct mailmap_info));
> -		debug_mm("mailmap: adding (complex) entry for %s at index %d\n",
> -			 old_email, index);
> +		debug_mm("mailmap: adding (complex) entry for '%s'\n", old_email);
>  		if (new_name)
>  			mi->name = xstrdup(new_name);
>  		if (new_email)
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
