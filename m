From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 5/5] Add documentation for --window-bytes, pack.windowBytes
Date: Thu, 12 Jul 2007 00:35:22 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0707120028020.32552@xanadu.home>
References: <11842100581060-git-send-email-bdowning@lavos.net>
 <1184210058514-git-send-email-bdowning@lavos.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Thu Jul 12 06:35:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8qOq-0008Mq-GO
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 06:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbXGLEfY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 00:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbXGLEfY
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 00:35:24 -0400
Received: from relais.videotron.ca ([24.201.245.36]:17692 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbXGLEfX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 00:35:23 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JL100D4YU2YKI10@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 12 Jul 2007 00:35:23 -0400 (EDT)
In-reply-to: <1184210058514-git-send-email-bdowning@lavos.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52243>

On Wed, 11 Jul 2007, Brian Downing wrote:

> Signed-off-by: Brian Downing <bdowning@lavos.net>
> ---
>  Documentation/config.txt           |    5 +++++
>  Documentation/git-pack-objects.txt |    8 ++++++++
>  Documentation/git-repack.txt       |    8 ++++++++
>  3 files changed, 21 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index aeece84..83c7dc1 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -592,6 +592,11 @@ pack.depth::
>  	The maximum delta depth used by gitlink:git-pack-objects[1] when no
>  	maximum depth is given on the command line. Defaults to 50.
>  
> +pack.windowBytes::
> +	This option provides an additional limit on top of `pack.window`;
> +	the window size will dynamically scale down so as to not take
> +	up more than N bytes in memory.
> +

This doesn't say what the default (unlimited) is.

>  pack.compression::
>  	An integer -1..9, indicating the compression level for objects
>  	in a pack file. -1 is the zlib default. 0 means no
> diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
> index e3549b5..21ed198 100644
> --- a/Documentation/git-pack-objects.txt
> +++ b/Documentation/git-pack-objects.txt
> @@ -85,6 +85,14 @@ base-name::
>  	times to get to the necessary object.
>  	The default value for --window is 10 and --depth is 50.
>  
> +--window-bytes=[N]::
> +	This option provides an additional limit on top of `--window`;
> +	the window size will dynamically scale down so as to not take
> +	up more than N bytes in memory.  This is useful in
> +	repositories with a mix of large and small objects to not run
> +	out of memory with a large window, but still be able to take
> +	advantage of the large window for the smaller objects.

Ditto here.

Also it is a bit akward to specify a size in bytes when you probably 
want to specify a limit which is in the megabyte range.  I'd call them 
--window_mem and pack.windowmemory, and allow for unit suffixes of 'k', 
'm', or 'g' to be supported if not already.


Nicolas
