From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH v2 01/16] pkt-line: Add strbuf based functions
Date: Tue, 13 Oct 2009 11:10:41 -0700
Message-ID: <20091013181041.GX9261@spearce.org>
References: <1255400715-10508-1-git-send-email-spearce@spearce.org> <1255400715-10508-2-git-send-email-spearce@spearce.org> <4AD42C52.80205@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 13 20:25:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxm35-0006Ju-K6
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 20:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760836AbZJMSLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 14:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760610AbZJMSLS
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 14:11:18 -0400
Received: from george.spearce.org ([209.20.77.23]:46657 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127AbZJMSLS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 14:11:18 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id CE903381FE; Tue, 13 Oct 2009 18:10:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4AD42C52.80205@viscovery.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130178>

Johannes Sixt <j.sixt@viscovery.net> wrote:
> Shawn O. Pearce schrieb:
> > -int packet_read_line(int fd, char *buffer, unsigned size)
> > +static int packet_length(unsigned *ret_len, const char *linelen)
...
> > +	*ret_len = len;
> > +	return 0;
> > +}
> 
> len can be signed: Valid lengths fit into a signed int. Then you can
> 'return len;' on success and 'return -1;' on failure and don't need return
> the result by reference. packet_read_line() ultimately converts it to int
> anyway:

Great catch, thanks.  This is actually from a prior version of code
where I was exposing this function to callers... but even then the
method could have just returned int with the value because as you
point out, all valid lengths fit in int and must be >= 0.
 
-- 
Shawn.
