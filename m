From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] graph API: Added logic for colored edges.
Date: Tue, 31 Mar 2009 12:21:22 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0903311213260.10279@pacific.mpi-cbg.de>
References: <20090318100512.GA7932@linux.vnet> <alpine.DEB.1.00.0903181228420.10279@pacific.mpi-cbg.de> <b2e43f8f0903190959if539048r19e972899bd2132d@mail.gmail.com> <alpine.DEB.1.00.0903191831590.6357@intel-tinevez-2-302> <20090320064813.6117@nanako3.lavabit.com>
 <b2e43f8f0903201213o396de6c0sb52149ed1d889d1@mail.gmail.com> <20090320195806.GC26934@coredump.intra.peff.net> <20090321175726.GA6677@linux.vnet> <20090330141322.GA6221@linux.vnet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Allan Caffee <allan.caffee@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 12:20:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lob5F-0002Ka-DC
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 12:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814AbZCaKTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 06:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752757AbZCaKTI
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 06:19:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:58878 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752577AbZCaKTG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 06:19:06 -0400
Received: (qmail invoked by alias); 31 Mar 2009 10:19:03 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp023) with SMTP; 31 Mar 2009 12:19:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+F+HIbImKFxM82bT/boT97m2xkbQriiw0gSOw0o5
	fVXo1I4Scv/tGR
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090330141322.GA6221@linux.vnet>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115246>

Hi,

On Mon, 30 Mar 2009, Allan Caffee wrote:

> @@ -445,6 +492,12 @@ static void graph_update_columns(struct git_graph *graph)
>  			for (parent = first_interesting_parent(graph);
>  			     parent;
>  			     parent = next_interesting_parent(graph, parent)) {
> +				/*
> +				 * If this is a merge increment the current
> +				 * color.
> +				 */
> +				if (graph->num_parents > 1)
> +					get_next_column_color(graph);
>  				graph_insert_into_new_columns(graph,
>  							      parent->item,
>  							      &mapping_idx);

Hmm.  I would have expected the color to be an argument to 
graph_insert_into_new_columns()...

Oh, and please forget about my stupid babbling about using struct 
decoration for colors: the column already knows commit and color, so if 
you need the color in a functino in addition to the commit, you should 
pass either the column struct instead, or the commit and the color as 
individual parameters.

This concludes my review ;-)

Thanks,
Dscho
