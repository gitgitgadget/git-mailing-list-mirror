From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH] send-email: recognize absolute path on Windows
Date: Tue, 15 Apr 2014 09:57:21 -0700
Message-ID: <xmqq61maledq.fsf_-_@gitster.dls.corp.google.com>
References: <1397551465-10968-1-git-send-email-kusmabite@gmail.com>
	<534D0ADB.7070702@viscovery.net>
	<CABPQNSafmC-7zNJZJSZm598pF37_xUMUopgZ3c=ttL_wRDYsfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>,  GIT Mailing-list <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>,  Johannes Schindelin <johannes.schindelin@gmx.de>
To: kusmabite@gmail.com
X-From: msysgit+bncBCG77UMM3EJRB5OJWWNAKGQEEZQRJII@googlegroups.com Tue Apr 15 18:57:29 2014
Return-path: <msysgit+bncBCG77UMM3EJRB5OJWWNAKGQEEZQRJII@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-oa0-f60.google.com ([209.85.219.60])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRB5OJWWNAKGQEEZQRJII@googlegroups.com>)
	id 1Wa6fn-0001wT-3R
	for gcvm-msysgit@m.gmane.org; Tue, 15 Apr 2014 18:57:27 +0200
Received: by mail-oa0-f60.google.com with SMTP id i4sf2112960oah.15
        for <gcvm-msysgit@m.gmane.org>; Tue, 15 Apr 2014 09:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=0LwzZ0/mPqzA14TAD3twnDbhNBL5b9EadGbwoXZbMr4=;
        b=TRHXaZ71jix8cDItPByk0s759Pk1Jj1n6ycv8hrrIbAnXnrXwMm1UHiH6uXILi/HGm
         JJ2b8eNp235WDWwoWZTYygIqGpQyWN4KOFnKhNK9fbDs23NMKWiWaxcCnF1Gxx+vpwmy
         nXUcoy9Wy/7pMp4QYEvhqUJjJZuGKOuL2QDejCZnxhWXEEfpMV9yU/Tj1k4p8oqpuxtR
         sc/Q8jmyjfDmA1T2YzvMwMMebL37KjRzMixYFlT57xw01O4WvK/SvmQCtzKKcTes9Voc
         Bq0e7+BxOaPal169ENyBKvYiG3x6U3+Ye3KdCTuZHZdjY0602mOEkU8jz+OVmOlqgD+B
         9X2A==
X-Received: by 10.51.17.36 with SMTP id gb4mr138915igd.4.1397581045992;
        Tue, 15 Apr 2014 09:57:25 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.26.5 with SMTP id h5ls2546030igg.29.canary; Tue, 15 Apr
 2014 09:57:25 -0700 (PDT)
X-Received: by 10.50.50.211 with SMTP id e19mr1890274igo.4.1397581045266;
        Tue, 15 Apr 2014 09:57:25 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id n7si1607070qcz.2.2014.04.15.09.57.25
        for <msysgit@googlegroups.com>;
        Tue, 15 Apr 2014 09:57:25 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E54837AA2E;
	Tue, 15 Apr 2014 12:57:24 -0400 (EDT)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D11F77AA2D;
	Tue, 15 Apr 2014 12:57:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E9B47AA2B;
	Tue, 15 Apr 2014 12:57:23 -0400 (EDT)
In-Reply-To: <CABPQNSafmC-7zNJZJSZm598pF37_xUMUopgZ3c=ttL_wRDYsfQ@mail.gmail.com>
	(Erik Faye-Lund's message of "Tue, 15 Apr 2014 12:42:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 03CF2792-C4BF-11E3-AA09-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246292>

Erik Faye-Lund <kusmabite@gmail.com> writes:

>>> Here's a patch that we've been running with a variation of in
>>> Git for Windows for a while. That version wasn't quite palatable,
>>> as it recognized DOS drive-prefixes on all platforms.
>>
>> Did you consider patching msysgit's lib/perl5/5.8.8/File/Spec.pm by
>> inserting a line "msys => 'Win32'," near the top of the file; it is the
>> hash table that decides which path "style" is selected depending on $^O.
>> Then File::Spec->file_name_is_absolute($path) could be used without a wrapper.
>
> I did not, but that works, and is IMO much nicer. Thanks for the idea!
> ...
>> There's another instance in the non-$quiet code path around line 1275 that
>> needs the same treatment.
>
> Good catch, thanks!

Thanks, both.  I'd expect another round then?

-- >8 --
From: Erik Faye-Lund <kusmabite@googlemail.com>

On Windows, absolute paths might start with a DOS drive prefix,
which these checks fail to recognize.

Use file_name_is_absolute from File::Spec::Functions for
portability.  The Perl module msysgit has been shipping needs to be
updated for this patch to work, though.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
Helepd-by: Johannes Sixt <j6t@kdbg.org>
---

 git-send-email.perl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index fdb0029..eda3917 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -25,7 +25,7 @@
 use Data::Dumper;
 use Term::ANSIColor;
 use File::Temp qw/ tempdir tempfile /;
-use File::Spec::Functions qw(catfile);
+use File::Spec::Functions qw(catfile file_name_is_absolute);
 use Error qw(:try);
 use Git;
 
@@ -1197,7 +1197,7 @@ sub send_message {
 
 	if ($dry_run) {
 		# We don't want to send the email.
-	} elsif ($smtp_server =~ m#^/#) {
+	} elsif (file_name_is_absolute($smtp_server)) {
 		my $pid = open my $sm, '|-';
 		defined $pid or die $!;
 		if (!$pid) {
@@ -1271,7 +1271,7 @@ sub send_message {
 		printf (($dry_run ? "Dry-" : "")."Sent %s\n", $subject);
 	} else {
 		print (($dry_run ? "Dry-" : "")."OK. Log says:\n");
-		if ($smtp_server !~ m#^/#) {
+		if (file_name_is_absolute($smtp_server)) {
 			print "Server: $smtp_server\n";
 			print "MAIL FROM:<$raw_from>\n";
 			foreach my $entry (@recipients) {

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
