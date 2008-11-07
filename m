From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 1/4] pack-objects: new option --honor-pack-keep
Date: Fri, 07 Nov 2008 09:13:21 +0100
Message-ID: <4913F8A1.2050304@op5.se>
References: <HBFmgmcvgPzZ0xq-fRUt98ZOBXGCvwxHGyEwF9bNcgpDgS-t-D3viw@cipher.nrlssc.navy.mil> <oDevG_2ETMLvy6rfSqvxfmFqABeVqlDUcU6FjP07E5IzqLaopWkQbQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Nov 07 09:15:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyMUz-0004Yr-Ax
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 09:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbYKGIOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 03:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbYKGIOF
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 03:14:05 -0500
Received: from mail.op5.se ([193.201.96.20]:55221 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751381AbYKGIOE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 03:14:04 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 6F0191B8008E;
	Fri,  7 Nov 2008 09:07:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2LLPuvIp-ZgJ; Fri,  7 Nov 2008 09:07:07 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 83C1C1B80136;
	Fri,  7 Nov 2008 09:07:05 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <oDevG_2ETMLvy6rfSqvxfmFqABeVqlDUcU6FjP07E5IzqLaopWkQbQ@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100293>

Brandon Casey wrote:
> This adds a new option to pack-objects which will cause it to ignore an
> object which appears in a local pack which has a .keep file, even if it
> was specified for packing.
> 
> This option will be used by the porcelain repack.
> 
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
> 
> 
> This series replaces the previous series starting at
> 6ee726bc "pack-objects: honor '.keep' files"
> 
> It should be applied on top of
> f34cf12d "packed_git: convert pack_local flag into a bitfield and add pack_keep"
> 
> I created the series on top of f34cf12d rebased on top of master.
> 
> Suggestions for a more appropriate name for --honor-pack-keep are very welcome.
> 
> -brandon
> 
> 
>  Documentation/git-pack-objects.txt |    5 +++++
>  builtin-pack-objects.c             |    7 +++++++
>  2 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
> index 8c354bd..f9fac2c 100644
> --- a/Documentation/git-pack-objects.txt
> +++ b/Documentation/git-pack-objects.txt
> @@ -109,6 +109,11 @@ base-name::
>  	The default is unlimited, unless the config variable
>  	`pack.packSizeLimit` is set.
>  
> +--honor-pack-keep::
> +	This flag causes an object already in a local pack that
> +	has a .keep file to be ignored, even if it appears in the
> +	standard input.
> +

Keep-files are *always* honored. Make this option "--ignore-kept" or
something instead, otherwise people will see the synopsis and think
they need to always pass it to not remove .keep-protected packs,
which is stupid.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
