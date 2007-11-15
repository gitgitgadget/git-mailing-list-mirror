From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] rehabilitate some t5302 tests on 32-bit off_t machines
Date: Thu, 15 Nov 2007 19:38:29 +0100
Message-ID: <200711151938.29617.johannes.sixt@telecom.at>
References: <alpine.LFD.0.9999.0711151211330.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 19:39:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Isjc2-00045f-Nv
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 19:38:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761442AbXKOSic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 13:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758169AbXKOSic
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 13:38:32 -0500
Received: from smtp2.srv.eunet.at ([193.154.160.116]:58361 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761442AbXKOSib (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 13:38:31 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp2.srv.eunet.at (Postfix) with ESMTP id 3C55FC0251;
	Thu, 15 Nov 2007 19:38:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id D283059D7B;
	Thu, 15 Nov 2007 19:38:29 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.0.9999.0711151211330.21255@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65148>

On Thursday 15 November 2007 18:24, Nicolas Pitre wrote:
> Commit 8ed2fca458d085f12c3c6808ef4ddab6aa40ef14 was a bit draconian in
> skipping certain tests which should be perfectly valid even on platform
> with a 32-bit off_t.
>
> Signed-off-by: Nicolas Pitre <nico@cam.org>
> ---
> diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
> index d93abc4..2a2878b 100755
> --- a/t/t5302-pack-index.sh
> +++ b/t/t5302-pack-index.sh
> @@ -129,17 +129,15 @@ test_expect_failure \
>      '[index v1] 6) newly created pack is BAD !' \
>      'git verify-pack -v "test-4-${pack1}.pack"'
>
> -test "$have_64bits" &&
>  test_expect_success \
>      '[index v2] 1) stream pack to repository' \
>      'rm -f .git/objects/pack/* &&
> -     git-index-pack --index-version=2,0x40000 --stdin 
< "test-1-${pack1}.pack" &&
> +     git-index-pack --index-version=2 --stdin <  "test-1-${pack1}.pack" && 
git prune-packed &&
>       git count-objects | ( read nr rest && test "$nr" -eq 1 ) &&
>       cmp "test-1-${pack1}.pack" ".git/objects/pack/pack-${pack1}.pack" &&
> -     cmp "test-3-${pack1}.idx"  ".git/objects/pack/pack-${pack1}.idx"'
> +     cmp "test-2-${pack1}.idx"  ".git/objects/pack/pack-${pack1}.idx"'

Since you changed this test, I assume that the remaining tests that you put 
back failed only because this one did something wrong. If so, please mention 
that in the commit message.

-- Hannes
