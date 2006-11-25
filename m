X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (amend)] gitweb: Use git-show-ref instead of git-peek-remote
Date: Sat, 25 Nov 2006 11:24:58 +0100
Organization: At home
Message-ID: <ek95ik$2f3$1@sea.gmane.org>
References: <7vhcwoa3mx.fsf@assigned-by-dhcp.cox.net> <11644499234152-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sat, 25 Nov 2006 10:23:53 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 38
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32276>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnuhF-0004Zc-AB for gcvg-git@gmane.org; Sat, 25 Nov
 2006 11:23:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966369AbWKYKXj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 05:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966391AbWKYKXj
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 05:23:39 -0500
Received: from main.gmane.org ([80.91.229.2]:30877 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S966369AbWKYKXi (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 05:23:38 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gnugx-0004Ur-1P for git@vger.kernel.org; Sat, 25 Nov 2006 11:23:27 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 25 Nov 2006 11:23:27 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 25 Nov 2006
 11:23:27 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:

Ooops. This is a part of next patch to send. Please delete this two chunks.
Sorry for the mistake.


> @@ -1293,8 +1294,9 @@ sub parse_commit {
>                       $co{'author'} = $1;
>                       $co{'author_epoch'} = $2;
>                       $co{'author_tz'} = $3;
> -                     if ($co{'author'} =~ m/^([^<]+) </) {
> -                             $co{'author_name'} = $1;
> +                     if ($co{'author'} =~ m/^([^<]+) <([^>]*)>/) {
> +                             $co{'author_name'}  = $1;
> +                             $co{'author_email'} = $2;
>                       } else {
>                               $co{'author_name'} = $co{'author'};
>                       }
> @@ -1303,7 +1305,12 @@ sub parse_commit {
>                       $co{'committer_epoch'} = $2;
>                       $co{'committer_tz'} = $3;
>                       $co{'committer_name'} = $co{'committer'};
> -                     $co{'committer_name'} =~ s/ <.*//;
> +                     if ($co{'committer'} =~ m/^([^<]+) <([^>]*)>/) {
> +                             $co{'committer_name'}  = $1;
> +                             $co{'committer_email'} = $2;
> +                     } else {
> +                             $co{'committer_name'} = $co{'committer'};
> +                     }
>               }
>       }
>       if (!defined $co{'tree'}) {

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

