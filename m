Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88EB620899
	for <e@80x24.org>; Tue,  8 Aug 2017 20:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752240AbdHHUUo (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 16:20:44 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38412 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752322AbdHHUUn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 16:20:43 -0400
Received: by mail-qk0-f194.google.com with SMTP id m84so3999794qki.5
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 13:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Mv4ut7Hq+0l2OQ9zBZxGwmfjhiNe/85Hly802G9HJUs=;
        b=VYmikOCZ7C2wl3+codt/zIoNaaDu8GqELF30eRyH+n3NwoMbZrZfR8WfdY0+yRSOxh
         YgOZi/Ahz8rTe0NGJ1RK4INtIcfcYXL2rDDEGJEqaXT1726dW4VzzlBRfeM+4+xtueVS
         RJ+JpMjmiumXcEYFzQpWCCK5vuGeLpWatSTmMV5YtzZ7mIjVUnzz/hhK/5LkFYJZAULf
         jZvPb2/L8adhhLGvHKkMW0lofAlh40LpOGBVBlQnL22XPUFSUn6QKziqwQ6WHPDRM07I
         5bBhkhKHm/JCYD2WWwuL07qnUZgnWTiJiSN3pTZ68oEqtVAC/9EoBtFVTegt+4IqOWg8
         TPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mv4ut7Hq+0l2OQ9zBZxGwmfjhiNe/85Hly802G9HJUs=;
        b=aVyYiuvP2LQ1GCoK81Nsmfx6805Mnx+VB6x14zFFnINQenohDhgOXp671CSkeCSdVH
         rMh1ep4KxvqxYzscDG+APYIoq4E1PseCEUPnWMQSU1XRVIS2IpwcX3Km9FOiJrsjvuV5
         tDUsWO2L+n7q+THx8TCLjeMIV0n4+3CqnNt3LHOvywp4UNeRFSmaRF1YOAYwOIRx4f/z
         1pxq0hsA7Imd4ILxRWaoNvJ0WCqiziEfgZthGc9KLOTCjojtC0dydxyK9DK/UGMcXwdb
         kEHqmcvb68/NMlDdD/W4+mHhNh05ctQiQ8BkOstAPb9tPPiF1kkYrXcJxjNZPXzOqMck
         yl3A==
X-Gm-Message-State: AHYfb5hp5WpmM+6NhDp7PiSbRpruorTXgu63Co3faESWgZ7jNoMIh3un
        fqqHcm5Oh3gqvw==
X-Received: by 10.55.41.153 with SMTP id p25mr7161347qkp.211.1502223642275;
        Tue, 08 Aug 2017 13:20:42 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id e192sm1165161qka.48.2017.08.08.13.20.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Aug 2017 13:20:41 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] sha1_file: support loading lazy objects
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com
References: <cover.1501532294.git.jonathantanmy@google.com>
 <eadce97b6a1e80345a2621e71ce187e9e6bc05bf.1501532294.git.jonathantanmy@google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <0c2a1339-0645-bb0c-216f-e093edf85994@gmail.com>
Date:   Tue, 8 Aug 2017 16:20:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <eadce97b6a1e80345a2621e71ce187e9e6bc05bf.1501532294.git.jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/31/2017 5:02 PM, Jonathan Tan wrote:
> Teach sha1_file to invoke the command configured in
> extensions.lazyObject whenever an object is requested and unavailable.
> 
> The usage of the hook can be suppressed through a flag when invoking
> has_object_file_with_flags() and other similar functions.
> 
> This is meant as a temporary measure to ensure that all Git commands
> work in such a situation. Future patches will update some commands to
> either tolerate missing objects (without invoking the command) or be
> more efficient in invoking this command.

To prevent fetch from downloading all missing objects, you will also 
need to add logic in check_connected.  The simplest model is to simply 
return 0 if repository_format_lazy_object is set.

/*
  * Running a with lazy_objects there will be objects that are
  * missing locally and we don't want to download a bunch of
  * commits, trees, and blobs just to make sure everything is
  * reachable locally so this option will skip reachablility
  * checks below that use rev-list.  This will stop the check
  * before uploadpack runs to determine if there is anything to
  * fetch.  Returning zero for the first check will also prevent the
  * uploadpack from happening.  It will also skip the check after
  * the fetch is finished to make sure all the objects where
  * downloaded in the pack file.  This will allow the fetch to
  * run and get all the latest tip commit ids for all the branches
  * in the fetch but not pull down commits, trees, or blobs via
  * upload pack.
  */
if (repository_format_lazy_object)
	return 0;

[...]
> diff --git a/sha1_file.c b/sha1_file.c
> index b60ae15f7..1785c61d8 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -28,6 +28,11 @@
>   #include "list.h"
>   #include "mergesort.h"
>   #include "quote.h"
> +#include "iterator.h"
> +#include "dir-iterator.h"
> +#include "sha1-lookup.h"
> +#include "lazy-object.h"
> +#include "sha1-array.h"
>   
>   #define SZ_FMT PRIuMAX
>   static inline uintmax_t sz_fmt(size_t s) { return s; }
> @@ -2984,6 +2989,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
>   	const unsigned char *real = (flags & OBJECT_INFO_LOOKUP_REPLACE) ?
>   				    lookup_replace_object(sha1) :
>   				    sha1;
> +	int already_retried = 0;
>   
>   	if (!oi)
>   		oi = &blank_oi;
> @@ -3008,30 +3014,38 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
>   		}
>   	}
>   
> -	if (!find_pack_entry(real, &e)) {
> -		/* Most likely it's a loose object. */
> -		if (!sha1_loose_object_info(real, oi, flags)) {
> -			oi->whence = OI_LOOSE;
> -			return 0;
> -		}
> +retry:
> +	if (find_pack_entry(real, &e))
> +		goto found_packed;
>   
> -		/* Not a loose object; someone else may have just packed it. */
> -		if (flags & OBJECT_INFO_QUICK) {
> -			return -1;
> -		} else {
> -			reprepare_packed_git();
> -			if (!find_pack_entry(real, &e))
> -				return -1;
> -		}
> +	/* Most likely it's a loose object. */
> +	if (!sha1_loose_object_info(real, oi, flags)) {
> +		oi->whence = OI_LOOSE;
> +		return 0;
>   	}
>   
> +	/* Not a loose object; someone else may have just packed it. */
> +	reprepare_packed_git();
> +	if (find_pack_entry(real, &e))
> +		goto found_packed;

Same feedback as before.  I like to avoid using goto's as flow control 
other than in error handling.

Also, this patch looses the OBJECT_INFO_QUICK logic which could be restored.

[...]

> diff --git a/t/t0410/lazy-object b/t/t0410/lazy-object
> new file mode 100755
> index 000000000..4f4a9c38a
> --- /dev/null
> +++ b/t/t0410/lazy-object
> @@ -0,0 +1,102 @@
> +#!/usr/bin/perl
> +#
> +# Example implementation for the Git lazyObject protocol version 1. See
> +# the documentation for extensions.lazyObject in
> +# Documentation/technical/repository-version.txt
> +#
> +# Allows you to test the ability for blobs to be pulled from a host git repo
> +# "on demand."  Called when git needs a blob it couldn't find locally due to
> +# a lazy clone that only cloned the commits and trees.
> +#
> +# Please note, this sample is a minimal skeleton. No proper error handling
> +# was implemented.
> +
> +use strict;
> +use warnings;
> +
> +#
> +# Point $DIR to the folder where your host git repo is located so we can pull
> +# missing objects from it
> +#
> +my $DIR = $ARGV[0];
> +

At some point, this should be based on the refactored pkt_* functions 
currently contained in the ObjectDB patch series.

> +sub packet_bin_read {
> +	my $buffer;
> +	my $bytes_read = read STDIN, $buffer, 4;
> +	if ( $bytes_read == 0 ) {
> +
> +		# EOF - Git stopped talking to us!
> +		exit();
> +	}
> +	elsif ( $bytes_read != 4 ) {
> +		die "invalid packet: '$buffer'";
> +	}
> +	my $pkt_size = hex($buffer);
> +	if ( $pkt_size == 0 ) {
> +		return ( 1, "" );
> +	}
> +	elsif ( $pkt_size > 4 ) {
> +		my $content_size = $pkt_size - 4;
> +		$bytes_read = read STDIN, $buffer, $content_size;
> +		if ( $bytes_read != $content_size ) {
> +			die "invalid packet ($content_size bytes expected; $bytes_read bytes read)";
> +		}
> +		return ( 0, $buffer );
> +	}
> +	else {
> +		die "invalid packet size: $pkt_size";
> +	}
> +}
> +
> +sub packet_txt_read {
> +	my ( $res, $buf ) = packet_bin_read();
> +	unless ( $buf =~ s/\n$// ) {
> +		die "A non-binary line MUST be terminated by an LF.";
> +	}
> +	return ( $res, $buf );
> +}
> +
> +sub packet_bin_write {
> +	my $buf = shift;
> +	print STDOUT sprintf( "%04x", length($buf) + 4 );
> +	print STDOUT $buf;
> +	STDOUT->flush();
> +}
> +
> +sub packet_txt_write {
> +	packet_bin_write( $_[0] . "\n" );
> +}
> +
> +sub packet_flush {
> +	print STDOUT sprintf( "%04x", 0 );
> +	STDOUT->flush();
> +}
> +
> +( packet_txt_read() eq ( 0, "git-lazy-object-client" ) ) || die "bad initialize";
> +( packet_txt_read() eq ( 0, "version=1" ) )		 || die "bad version";
> +( packet_bin_read() eq ( 1, "" ) )                       || die "bad version end";
> +
> +packet_txt_write("git-lazy-object-server");
> +packet_txt_write("version=1");
> +packet_flush();
> +
> +( packet_txt_read() eq ( 0, "capability=get" ) )    || die "bad capability";
> +( packet_bin_read() eq ( 1, "" ) )                  || die "bad capability end";
> +
> +packet_txt_write("capability=get");
> +packet_flush();
> +
> +while (1) {
> +	my ($command) = packet_txt_read() =~ /^command=([^=]+)$/;
> +
> +	if ( $command eq "get" ) {
> +		my ($sha1) = packet_txt_read() =~ /^sha1=([0-9a-f]{40})$/;
> +		packet_bin_read();
> +
> +		system ('git --git-dir="' . $DIR . '" cat-file blob ' . $sha1 . ' | git -c extensions.lazyobject=false hash-object -w --stdin >/dev/null 2>&1');
> +		packet_txt_write(($?) ? "status=error" : "status=success");
> +		packet_flush();
> +	} else {
> +		die "bad command '$command'";
> +	}
> +}
> 
