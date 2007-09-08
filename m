From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] diff-delta.c: pack the index structure
Date: Fri, 07 Sep 2007 22:34:47 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0709072215420.21186@xanadu.home>
References: <85fy1q11xv.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Sep 08 04:34:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITq9v-0003KA-DX
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 04:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbXIHCet (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 22:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752076AbXIHCet
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 22:34:49 -0400
Received: from relais.videotron.ca ([24.201.245.36]:60042 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbXIHCes (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 22:34:48 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JO1007SG35ZJS21@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 07 Sep 2007 22:34:47 -0400 (EDT)
In-reply-to: <85fy1q11xv.fsf@lola.goethe.zz>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58098>

On Sat, 8 Sep 2007, David Kastrup wrote:

> In normal use cases, the performance wins are not overly impressive:
> we get something like 5-10% due to the slightly better locality of
> memory accesses using the packed structure.

The gain is probably counterbalanced by the fact that you're copying the 
whole index when packing it, which is unfortunate.

Also, could you provide actual test results backing your performance 
claim?  5-10% is still not negligible.

> -	struct index_entry *entry, **hash;
> +	struct unpacked_index_entry *entry, **hash;
> +	struct index_entry *aentry, **ahash;

What does the "a" stand for?

> +	mem = index+1;
[...]
> +	for (i=0; i<hsize; i++) {
[...]
> +		for (entry=hash[i]; entry; entry=entry->next)

Minor style nit: please add spaces around "+", "=", "<", etc. for 
consistency.

Otherwise that looks fine to me.


Nicolas
