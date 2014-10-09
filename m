From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/14] MINGW: config.mak.uname: auto-detect
 MinGW build from compiler
Date: Thu, 09 Oct 2014 00:34:25 -0700
Message-ID: <xmqqzjd57l32.fsf@gitster.dls.corp.google.com>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org>
	<1412791267-13356-15-git-send-email-marat@slonopotamus.org>
	<xmqqoatm8irn.fsf@gitster.dls.corp.google.com>
	<20141009050318.GA17479@seldon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org,  msysGit <msysgit@googlegroups.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: msysgit+bncBCG77UMM3EJRBA7V3CQQKGQEH4VVPJI@googlegroups.com Thu Oct 09 09:34:32 2014
Return-path: <msysgit+bncBCG77UMM3EJRBA7V3CQQKGQEH4VVPJI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ig0-f192.google.com ([209.85.213.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBA7V3CQQKGQEH4VVPJI@googlegroups.com>)
	id 1Xc8F3-0003Vx-9m
	for gcvm-msysgit@m.gmane.org; Thu, 09 Oct 2014 09:34:29 +0200
Received: by mail-ig0-f192.google.com with SMTP id r10sf230974igi.19
        for <gcvm-msysgit@m.gmane.org>; Thu, 09 Oct 2014 00:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=dds2Xa18d5aMc3GhLaoNdfIUo2G6NVg8EaKitiEpUAs=;
        b=HNYM55ahf5+tRld3udclpGhWAdFTgpKzrNT+41lXK8uwSPHUVMmanLc1Ohi0cB9oUU
         D4F6Pl5MNzDpqrUEFrn7Hkds2wrTBbFSScpteFrwej1HaTLF3e9Qb/ReK0z2bA0iYvaS
         MoGPJtwu49c6TrEou1qYk3kr655FryQNXvwZMozvNfG7oqSGhQixgL5lnJ5Su3iKbzo3
         ET/Vc5Irthk852BoZENNttQSda6XOQzkmwg5lsioqOUsvurs3yd5GUvJMC4XCBKgJaDE
         A0Z6jRXelIxRJ+9Uh1T5Tgl+LIHm0pnwAvSFDX5FZA7DJvVjyu9PiaZscECUDL38MWU2
         P+AA==
X-Received: by 10.182.213.228 with SMTP id nv4mr12717obc.24.1412840068407;
        Thu, 09 Oct 2014 00:34:28 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.80.167 with SMTP id s7ls146931obx.57.gmail; Thu, 09 Oct
 2014 00:34:27 -0700 (PDT)
X-Received: by 10.182.45.197 with SMTP id p5mr10495076obm.2.1412840067563;
        Thu, 09 Oct 2014 00:34:27 -0700 (PDT)
Received: from sasl.smtp.pobox.com (pb-smtp1.int.icgroup.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id fl6si706349qcb.0.2014.10.09.00.34.27
        for <msysgit@googlegroups.com>;
        Thu, 09 Oct 2014 00:34:27 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E3EC11D09;
	Thu,  9 Oct 2014 03:34:27 -0400 (EDT)
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 266ED11D08;
	Thu,  9 Oct 2014 03:34:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A48FA11D07;
	Thu,  9 Oct 2014 03:34:26 -0400 (EDT)
In-Reply-To: <20141009050318.GA17479@seldon> (Marat Radchenko's message of
	"Thu, 9 Oct 2014 09:03:18 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B27F367C-4F86-11E4-B2AA-855A93717476-77302942!pb-smtp1.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted
 sender) smtp.mail=junio@pobox.com;       dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>

Marat Radchenko <marat@slonopotamus.org> writes:

> On Wed, Oct 08, 2014 at 12:26:52PM -0700, Junio C Hamano wrote:
> ...
>> What I am wondering is if it is a better solution to make it easier
>> to allow somebody who is cross compiling to express "Mr.  Makefile,
>> we know better than you and want you to do a MINGW build for us
>> without checking with `uname -?` yourself", i.e.
>> 
>> 	$ make uname_O=MINGW uname_S=MINGW
>> 
>> which would hopefully allow cross-compilation into other
>> environments, not just MINGW.
>
> So, do you really want this patch to be changed from 5-liner into
> a full-blow system detection rewrite based on `cc -dumpmachine`
> instead of `uname`?

No, and I do not quite see why you even need to look at -dumbmachine
output when your goal is to make this command line

>> 	$ make uname_O=MINGW uname_S=MINGW

work sensibly.  Wouldn't it be more like a series of

	ifndef uname_O
        uname_O := $(shell uname -o)
	endif

or something like that?

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
