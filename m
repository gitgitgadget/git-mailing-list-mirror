Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EA6B20357
	for <e@80x24.org>; Fri, 14 Jul 2017 15:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754545AbdGNPSa (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 11:18:30 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34078 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754399AbdGNPS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 11:18:29 -0400
Received: by mail-qk0-f173.google.com with SMTP id d78so77805462qkb.1
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 08:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=21SDbAtNIzyckvptVjjd3LlRV9WYJQA7IOzzUgRa3D8=;
        b=X9ZpNgQUFSyb2gpsWCEWax/dgYC1X47nT+rlgyYTCi86HJbXgvAa9zKpwS6E4pBTWv
         rrt6kc/D6Ti6bgHqWx4a0VFOQP/7igsY2/0L9KPGre96r2/ikkV4i4cJL5+RNhPo9Pvl
         /tw+ZtGC95uhBFwgGXL5/2YjIPDdmdkhmf6wBcVOkGqHmDK+Bshy1qiRhSk5LIFUvsdZ
         DKvqwvCBJZyI6rMLJ40T55Q/Danx7QUBDnV5wgqlnSD+B6HnR2OESjOesskYnf/9LAgR
         e//XmE7ufD6DzoaWXN6RzPg8EPOLuvgy+TlnVmb/WWky3w/LOzMtFlVrUMRZvTuNG3Jb
         ba/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=21SDbAtNIzyckvptVjjd3LlRV9WYJQA7IOzzUgRa3D8=;
        b=I+ZJzl6ASDFl4eVYdudNK4IFzrzus2zmjglRHvbqK836dYjJV/GSNYaZJQI3dK6UtY
         IT4sx68sdEm0fXBtmKNzNqB51d30O+inoMREIPqgW8uBhD9ZUq0UJKIjJPP5P6Fx5P19
         +8S/fmoF8DOPlVm4twFrrzPM7i0hggmMbqT1aflIEM6eBQN1qnLFvmVA9eG0h44FZ6a3
         V1T0bYYj4P7Brfub2qJ6v9B3urJgBYgxbfBALrLRWA6siQsatFNtX25ojO390+KzcOsb
         GSIHiQf+e26PsT7pStGCclMGlT2FzAjad598CyX9q8JzVuY+ib40TLV3U0oOpCKNMQNo
         XpAg==
X-Gm-Message-State: AIVw111rieh7Ppr8sIHguMW7p614fhL4WhsbN5XO24YoYCk13KEJVX6l
        Bueur6WcTnJFD495nnPd+ZTNP0F2Rw==
X-Received: by 10.55.124.67 with SMTP id x64mr11392609qkc.98.1500045508363;
 Fri, 14 Jul 2017 08:18:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.31.13 with HTTP; Fri, 14 Jul 2017 08:18:27 -0700 (PDT)
In-Reply-To: <20170714132651.170708-2-benpeart@microsoft.com>
References: <20170714132651.170708-1-benpeart@microsoft.com> <20170714132651.170708-2-benpeart@microsoft.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 14 Jul 2017 17:18:27 +0200
Message-ID: <CAP8UFD2tQQ3Dyx64LMtt_+WRoDS9V+AbMtvdCcngqiL5kCBFTg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] sha1_file: Add support for downloading blobs on demand
To:     Ben Peart <peartben@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 14, 2017 at 3:26 PM, Ben Peart <peartben@gmail.com> wrote:

> diff --git a/contrib/long-running-read-object/example.pl b/contrib/long-running-read-object/example.pl
> new file mode 100755
> index 0000000000..b8f37f836a
> --- /dev/null
> +++ b/contrib/long-running-read-object/example.pl

[...]

> +sub packet_bin_read {
> +       my $buffer;
> +       my $bytes_read = read STDIN, $buffer, 4;
> +       if ( $bytes_read == 0 ) {
> +
> +               # EOF - Git stopped talking to us!
> +               exit();
> +       }
> +       elsif ( $bytes_read != 4 ) {
> +               die "invalid packet: '$buffer'";
> +       }
> +       my $pkt_size = hex($buffer);
> +       if ( $pkt_size == 0 ) {
> +               return ( 1, "" );
> +       }
> +       elsif ( $pkt_size > 4 ) {
> +               my $content_size = $pkt_size - 4;
> +               $bytes_read = read STDIN, $buffer, $content_size;
> +               if ( $bytes_read != $content_size ) {
> +                       die "invalid packet ($content_size bytes expected; $bytes_read bytes read)";
> +               }
> +               return ( 0, $buffer );
> +       }
> +       else {
> +               die "invalid packet size: $pkt_size";
> +       }
> +}
> +
> +sub packet_txt_read {
> +       my ( $res, $buf ) = packet_bin_read();
> +       unless ( $buf =~ s/\n$// ) {
> +               die "A non-binary line MUST be terminated by an LF.";
> +       }
> +       return ( $res, $buf );
> +}
> +
> +sub packet_bin_write {
> +       my $buf = shift;
> +       print STDOUT sprintf( "%04x", length($buf) + 4 );
> +       print STDOUT $buf;
> +       STDOUT->flush();
> +}
> +
> +sub packet_txt_write {
> +       packet_bin_write( $_[0] . "\n" );
> +}
> +
> +sub packet_flush {
> +       print STDOUT sprintf( "%04x", 0 );
> +       STDOUT->flush();
> +}

The above could reuse the refactoring of t0021/rot13-filter.pl into
perl/Git/Packet.pm that is at the beginning of my patch series.

> diff --git a/t/t0410/read-object b/t/t0410/read-object
> new file mode 100755
> index 0000000000..85e997c930
> --- /dev/null
> +++ b/t/t0410/read-object

[...]

> +sub packet_bin_read {
> +       my $buffer;
> +       my $bytes_read = read STDIN, $buffer, 4;
> +       if ( $bytes_read == 0 ) {
> +
> +               # EOF - Git stopped talking to us!
> +               exit();
> +       }
> +       elsif ( $bytes_read != 4 ) {
> +               die "invalid packet: '$buffer'";
> +       }
> +       my $pkt_size = hex($buffer);
> +       if ( $pkt_size == 0 ) {
> +               return ( 1, "" );
> +       }
> +       elsif ( $pkt_size > 4 ) {
> +               my $content_size = $pkt_size - 4;
> +               $bytes_read = read STDIN, $buffer, $content_size;
> +               if ( $bytes_read != $content_size ) {
> +                       die "invalid packet ($content_size bytes expected; $bytes_read bytes read)";
> +               }
> +               return ( 0, $buffer );
> +       }
> +       else {
> +               die "invalid packet size: $pkt_size";
> +       }
> +}
> +
> +sub packet_txt_read {
> +       my ( $res, $buf ) = packet_bin_read();
> +       unless ( $buf =~ s/\n$// ) {
> +               die "A non-binary line MUST be terminated by an LF.";
> +       }
> +       return ( $res, $buf );
> +}
> +
> +sub packet_bin_write {
> +       my $buf = shift;
> +       print STDOUT sprintf( "%04x", length($buf) + 4 );
> +       print STDOUT $buf;
> +       STDOUT->flush();
> +}
> +
> +sub packet_txt_write {
> +       packet_bin_write( $_[0] . "\n" );
> +}
> +
> +sub packet_flush {
> +       print STDOUT sprintf( "%04x", 0 );
> +       STDOUT->flush();
> +}

Same thing about the above and perl/Git/Packet.pm.

Otherwise thanks for updating this!
