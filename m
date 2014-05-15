From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git grep -O -i: if the pager is 'less', pass
 the '-i' option
Date: Thu, 15 May 2014 12:48:48 -0700
Message-ID: <xmqqha4qesbj.fsf@gitster.dls.corp.google.com>
References: <20140514155010.GA4592@camelia.ucw.cz>
	<xmqq7g5okztp.fsf@gitster.dls.corp.google.com>
	<20140514182654.GA9218@google.com>
	<xmqqvbt8jjlg.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1405151943310.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,  Stepan Kasal <kasal@ucw.cz>,  GIT Mailing-list <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBCG77UMM3EJRBBFY2SNQKGQETYBMCAA@googlegroups.com Thu May 15 21:56:55 2014
Return-path: <msysgit+bncBCG77UMM3EJRBBFY2SNQKGQETYBMCAA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ob0-f183.google.com ([209.85.214.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBBFY2SNQKGQETYBMCAA@googlegroups.com>)
	id 1Wl1lu-0008Ne-6G
	for gcvm-msysgit@m.gmane.org; Thu, 15 May 2014 21:56:54 +0200
Received: by mail-ob0-f183.google.com with SMTP id uy5sf429475obc.0
        for <gcvm-msysgit@m.gmane.org>; Thu, 15 May 2014 12:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=6qLPl798Qg9atVYKSvy9sQ6hsIubc6ilxITGkbq7Quo=;
        b=JjG9k5SExEi8hCRYpkWDLibSA2zQJbpoDP42Wo5POBLK8uAFzk5yapczLOzYjHGUiE
         94M033KSKmLM//dES5334MNbGhQbxwmfS3yqYBZDZQKwVUUelt3eMuYEadMEmObScOOe
         VX8lQA2pOTZSki7nRt5r2a15imjXbxGnCdQ+qByXc9XEW+iCWhKivkirA0CKbDZMN/Yo
         XOkPZQ59kwEGMKwi9rT21O/3zsuAyJ8rkL5n6QA75clBoNeB22zQ3ZqwPhZOJ6/u0zar
         sBlWwLTn5jLU5/YNQvuye5A5nERAQGkxa75P1E5B/TtqJu3QjLSm4JFek2rwrOIBEuxj
         tpfg==
X-Received: by 10.182.118.138 with SMTP id km10mr90747obb.27.1400183813323;
        Thu, 15 May 2014 12:56:53 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.65.231 with SMTP id a7ls119250obt.30.gmail; Thu, 15 May
 2014 12:56:52 -0700 (PDT)
X-Received: by 10.182.38.199 with SMTP id i7mr5971582obk.35.1400183812228;
        Thu, 15 May 2014 12:56:52 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id y50si294213yhk.4.2014.05.15.12.56.52
        for <msysgit@googlegroups.com>;
        Thu, 15 May 2014 12:56:52 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F1F5216AE4;
	Thu, 15 May 2014 15:56:51 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E878216AE2;
	Thu, 15 May 2014 15:56:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 66F111630A;
	Thu, 15 May 2014 15:48:50 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1405151943310.14982@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Thu, 15 May 2014 19:44:08 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EFD0A6B8-DC69-11E3-BD3A-DDB853EDF712-77302942!pb-smtp0.pobox.com
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
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249198>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Jonathan Nieder <jrnieder@gmail.com> writes:
>> 
>> >>> +		if (opt.ignore_case && !strcmp("less", pager))
>> >>> +			string_list_append(&path_list, "-i");
>> >>
>> >> I have a feeling that this goes against the recent trend of not
>> >> mucking with the expectation of the users on their pagers, if I
>> >> recall correctly the arguments for dropping S from the default given
>> >> to an unconfigured LESS environment variable.
>> >
>> > It's just missing an explanation.
>> > ...
>> > (That's -I, not -i, because it ought to work even when the pattern
>> > contains capital letters.)
>> 
>> Spot on.  The change, especially with "-I", makes sense.
>
> Except that it was not tested with -I. If you change it that way and it
> stops working on Windows, it's useless to me.

That is all true, and I didn't test on Windows, but it seems that
the feature is very old in the upstream that we can rely on, so
let's take Jonathan's explanation and queue somethink like this.

-- >8 --
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Tue, 8 Feb 2011 00:17:24 -0600
Subject: [PATCH] git grep -O -i: if the pager is 'less', pass the '-I' option

When <command> happens to be the magic string "less", today

	git grep -O<command> -e<pattern>

helpfully passes +/<pattern> to less so you can navigate through
the results within a file using the n and shift+n keystrokes.

Alas, that doesn't do the right thing for a case-insensitive match,
i.e.

	git grep -i -O<command> -e<pattern>

For that case we should pass --IGNORE-CASE to "less" so that n and
shift+n can move between results ignoring case in the pattern.

The original patch came from msysgit and used "-i", but that was not
due to lack of support for "-I" but it merely overlooked that it
ought to work even when the pattern contains capital letters.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/grep.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index 63f8603..c0573d0 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -876,6 +876,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		if (len > 4 && is_dir_sep(pager[len - 5]))
 			pager += len - 4;
 
+		if (opt.ignore_case && !strcmp("less", pager))
+			string_list_append(&path_list, "-I");
+
 		if (!strcmp("less", pager) || !strcmp("vi", pager)) {
 			struct strbuf buf = STRBUF_INIT;
 			strbuf_addf(&buf, "+/%s%s",
-- 
2.0.0-rc3-419-gdb851f2

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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
