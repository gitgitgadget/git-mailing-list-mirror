From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Colorization of log --graph
Date: Wed, 18 Mar 2009 12:44:10 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903181228420.10279@pacific.mpi-cbg.de>
References: <20090318100512.GA7932@linux.vnet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Allan Caffee <allan.caffee@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 12:43:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjuBY-000636-V3
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 12:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755356AbZCRLmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 07:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754693AbZCRLmU
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 07:42:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:52034 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750979AbZCRLmT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 07:42:19 -0400
Received: (qmail invoked by alias); 18 Mar 2009 11:42:15 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp016) with SMTP; 18 Mar 2009 12:42:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+1fDh5IhK1YK39ZNeRSOMIpTIjCrgbejqSAoNJXR
	PfL3NCZMD/sdts
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090318100512.GA7932@linux.vnet>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113611>

Hi,

On Wed, 18 Mar 2009, Allan Caffee wrote:

> I know that _some_ people arn't particularly fond of colors, but I was 
> wondering how difficult it would be to colorize the edges on the --graph 
> drawn by the log command?  It can be a little tricky trying to follow 
> them with a relatively complex history.  I was thinking something like 
> gitk already does.

That's a good idea!  (And it is mentioned as a TODO in graph.c...)

> Is anybody else interested in seeing this?

Count me in.  Are you interested in implementing this?

If so:

- you need to #include "color.h" in graph.c

- you need to insert a color identifier into struct column (there is an 
  XXX comment at the correct location)

- you need to find a way to determine colors for the branches

- you need to put the handling into the function 
  graph_output_pre_commit_line() in graph.c (and probably 
  graph_output_commit_char(), graph_output_post_merge_line(), 
  graph_output_collapsing_line(), graph_padding_line(), and
  graph_output_padding_line(), too)

- it would make sense IMHO to introduce a new function that takes a 
  pointer to an strbuf, a pointer to a struct column and a char (or maybe 
  a string) that adds the appropriately colorized char (or string) to the 
  strbuf

- use the global variable diff_use_color to determine if the output should 
  be colorized at all

- probably you need to make an array of available colors or some such 
  (which might be good to put into color.[ch])

Ciao,
Dscho
