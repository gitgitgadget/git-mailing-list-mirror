Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5613AC32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 23:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjARXPC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 18:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjARXO5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 18:14:57 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357B362D33
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 15:14:56 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id u19so1240480ejm.8
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 15:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=knS0IBbmQnjXscHSrzg0zhVx9ate/5IwV25iT4uG3Jg=;
        b=iPE/oeVdwFv4xSmkhH55qgGtw66+PeTU/5KgiIaFq59f+eDG53qqP7cPKCiKKlGrYx
         P0r4THTjuH++uyZaHvq+2/1qHDTw3mUpdUL8HTiamsqDnE2YlVYU6hRzOCK+9pANr8Ec
         7keZkn4kJjDdJYVaQcHMrcciDuROENFajKQTRgTFy/IiA7tSb8JKwTcZHwzf1DiEmcmN
         PernoapXXOZAAF/0IRfvRTPTjLqgiC1CB0yv9IK9b/ELcwQYmRXHoqqNirANhPucZ/RE
         1YWN41vg2Y8wKKphmSDU8kwLI9cOYqyeHArlWx3kot8ekfVxw/de9FRZwPo7N0L5R9hO
         x4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knS0IBbmQnjXscHSrzg0zhVx9ate/5IwV25iT4uG3Jg=;
        b=0ooxYmtacJ2D3WpX3FMvVMc/wMcXbic32BJ8EpLx/XI0kbyXYlVOn3oviOHvdlrLlD
         tWuoO4EWHCbulBUUWfQpEi0BaxX1O4Qlopri0M+4wyNGpLktHGnGkxSXU+GCPnlgFOAE
         ZlpD1/3jBq+0bhhADLH8YVWDb4MYwn59vhm6Nf6Uar+gIQvIC83inpg8F3gpoOZhZymK
         YFKsqMeJi7nOnpt9l0J8M8KkKWkEOWb/DR/Bxirh+++7KNHGfU40LfHRaR1kjdaexECL
         +vhcRpBQfhLKqvRVe5KPIcLcdumGPM5X/VBNTbF0sCFWyldOGfhKXztpsC7zeuoLEBwJ
         RsyA==
X-Gm-Message-State: AFqh2kpZtfkDQ9ShO/XOHbJr3tWBFCtWi03E28NFuYtPAZVAudRG8FKG
        4p/QUFupK2sNIYnWrhqtcY6Uv1WvGZqJkw==
X-Google-Smtp-Source: AMrXdXtwoZ1FzwF8gntqlAV0sy1yrd534/v95IlsTwIhFardOojM9XOn+R8avo3w4o6k+Yn9hw7pCA==
X-Received: by 2002:a17:906:2c45:b0:84d:4b8f:b34c with SMTP id f5-20020a1709062c4500b0084d4b8fb34cmr8606452ejh.66.1674083694398;
        Wed, 18 Jan 2023 15:14:54 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id du1-20020a17090772c100b0084bfd56fb3bsm15239463ejc.162.2023.01.18.15.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 15:14:53 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pIHdt-003CNp-1O;
        Thu, 19 Jan 2023 00:14:53 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Michael Strawbridge <michael.strawbridge@amd.com>
Cc:     git@vger.kernel.org, Luben Tuikov <luben.tuikov@amd.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
Date:   Thu, 19 Jan 2023 00:12:25 +0100
References: <20230118163203.488652-1-michael.strawbridge@amd.com>
 <20230118163203.488652-3-michael.strawbridge@amd.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230118163203.488652-3-michael.strawbridge@amd.com>
Message-ID: <230119.868rhzwi36.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 18 2023, Michael Strawbridge wrote:

> To allow further flexibility in the Git hook, the SMTP header
> information of the email which git-send-email intends to send, is now
> passed as the 2nd argument to the sendemail-validate hook.
>
> As an example, this can be useful for acting upon keywords in the
> subject or specific email addresses.
>
> As a consequence of needing all the header data, validation has been
> moved later in the sequence to right before sending the emails instead
> of at the beginning.

Ah, I see. I tested this (i.e. moving it back to the previous behavior)
and you did this change because you don't have the $sender variable yet.

I tried this quickly on top, which seems to work, i.e. now we do this in
the same order as before, but we just move the $sender code earlier:
	
	diff --git a/git-send-email.perl b/git-send-email.perl
	index d123dfd33d5..7e7681116bb 100755
	--- a/git-send-email.perl
	+++ b/git-send-email.perl
	@@ -787,6 +787,28 @@ sub is_format_patch_arg {
	 
	 @files = handle_backup_files(@files);
	 
	+if (defined $sender) {
	+	$sender =~ s/^\s+|\s+$//g;
	+	($sender) = expand_aliases($sender);
	+} else {
	+	$sender = $repoauthor->() || $repocommitter->() || '';
	+}
	+
	+# $sender could be an already sanitized address
	+# (e.g. sendemail.from could be manually sanitized by user).
	+# But it's a no-op to run sanitize_address on an already sanitized address.
	+$sender = sanitize_address($sender);
	+
	+if ($validate) {
	+	foreach my $f (@files) {
	+		unless (-p $f) {
	+		        pre_process_file($f, 1);
	+
	+			validate_patch($f, $target_xfer_encoding);
	+		}
	+	}
	+}
	+
	 if (@files) {
	 	unless ($quiet) {
	 		print $_,"\n" for (@files);
	@@ -1035,18 +1057,6 @@ sub file_declares_8bit_cte {
	 	}
	 }
	 
	-if (defined $sender) {
	-	$sender =~ s/^\s+|\s+$//g;
	-	($sender) = expand_aliases($sender);
	-} else {
	-	$sender = $repoauthor->() || $repocommitter->() || '';
	-}
	-
	-# $sender could be an already sanitized address
	-# (e.g. sendemail.from could be manually sanitized by user).
	-# But it's a no-op to run sanitize_address on an already sanitized address.
	-$sender = sanitize_address($sender);
	-
	 my $to_whom = __("To whom should the emails be sent (if anyone)?");
	 my $prompting = 0;
	 if (!@initial_to && !defined $to_cmd) {
	@@ -1120,16 +1130,6 @@ sub expand_one_alias {
	 
	 $time = time - scalar $#files;
	 
	-if ($validate) {
	-	foreach my $f (@files) {
	-		unless (-p $f) {
	-		        pre_process_file($f, 1);
	-
	-			validate_patch($f, $target_xfer_encoding);
	-		}
	-	}
	-}
	-
	 $in_reply_to = $initial_in_reply_to;
	 $references = $initial_in_reply_to || '';
	 $message_num = 0;

All tests pass with that, which is less good than it sounds, because
shouldn't your tests be checking whether we have this non--quiet
print-out of the files as expected before or after the validation hook
runs?

> +
> +			my ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, $header) = gen_header();
> +
> +			require File::Temp;
> +			my ($header_filehandle, $header_filename) = File::Temp::tempfile(
> +                            ".gitsendemail.header.XXXXXX", DIR => $repo->repo_path());
> +			print $header_filehandle $header;
> +
>  			my @cmd = ("git", "hook", "run", "--ignore-missing",
>  				    $hook_name, "--");
> -			my @cmd_msg = (@cmd, "<patch>");
> -			my @cmd_run = (@cmd, $target);
> +			my @cmd_msg = (@cmd, "<patch>", "<header>");
> +			my @cmd_run = (@cmd, $target, $header_filename);
>  			$hook_error = system_or_msg(\@cmd_run, undef, "@cmd_msg");
> +			unlink($header_filehandle);
>  			chdir($cwd_save) or die("chdir: $!");

I'm still curious about the "stdin" question I asked in the last round.
