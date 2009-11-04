From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] MSVC: port pthread code to native Windows threads
Date: Wed, 4 Nov 2009 15:04:09 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0911041427140.2788@felix-maschine>
References: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com> <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 15:05:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5gTG-0004Sg-31
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 15:04:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756070AbZKDOEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 09:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755759AbZKDOEJ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 09:04:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:56315 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755728AbZKDOEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 09:04:09 -0500
Received: (qmail invoked by alias); 04 Nov 2009 14:04:12 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO [10.1.35.45]) [141.5.11.5]
  by mail.gmx.net (mp060) with SMTP; 04 Nov 2009 15:04:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX190TQxQazB0VdgsnPcHk+mS5L9xdkosb7k6BwR+EO
	o05yHvSeAiCugs
X-X-Sender: johannes@felix-maschine
In-Reply-To: <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132085>

Hi,

On Wed, 4 Nov 2009, Andrzej K. Haczewski wrote:


> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index 02f9246..c96d293 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -2327,6 +2327,18 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  #ifdef THREADED_DELTA_SEARCH
>  	if (!delta_search_threads)	/* --threads=0 means autodetect */
>  		delta_search_threads = online_cpus();
> +
> +#ifdef _WIN32

This flies in the face of our endeavors to enhance readability by reducing 
the number of #ifdef's, and at least guarding the #ifdef'ed parts behind 
meaningful names rather than platform specifiers.

See for example THREADED_DELTA_SEARCH: it does not read "HAS_PTHREADS" or 
some such.

Ciao,
Dscho
