From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 03/10] pkt-line: clean up "gentle" reading function
Date: Mon, 18 Feb 2013 02:12:09 -0800
Message-ID: <20130218101209.GC7049@elie.Belkin>
References: <20130218091203.GB17003@sigill.intra.peff.net>
 <20130218091619.GC5096@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 18 11:12:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7NiB-0004Qo-JG
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 11:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757864Ab3BRKMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 05:12:15 -0500
Received: from mail-pb0-f41.google.com ([209.85.160.41]:63823 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757849Ab3BRKMO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 05:12:14 -0500
Received: by mail-pb0-f41.google.com with SMTP id um15so1610170pbc.28
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 02:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=x59MRav1o1+C1wEkyUakvtLRdrqShqmBN+lvCrffJa8=;
        b=DQrdhUSE1W15YdaUY0BuU4I46KFQrJTvcHDjm6YTL9V6dKJj6z3sJ5oVjDNTkZxk+U
         83FnZq2El0r5skv84KYer+LFFdQq6FFbBjRo1cqxOKEg3vEKi3xpt1Ei1O5/jW8ADbAA
         RoaefzbIFSmqu1Er52FrA86/fHCEYKENAVPF0UZuUaqLNSzJX/JtIyUdi/Mib+sESwau
         n3BuJk5WbyVGDGOpkh/EgwZby7GBbQQ/RySvBzJjtQvDXMAcDktAWtFn5dnk9en4FsP5
         da3wJClSzLDYJ7D3GQSYV/T7CxxTKh+D+2UaDb8EEDEyzkIRL8d3nfLuDssIGpKqVv+n
         R3Fg==
X-Received: by 10.68.230.225 with SMTP id tb1mr28483768pbc.86.1361182334347;
        Mon, 18 Feb 2013 02:12:14 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ww9sm14022874pbc.41.2013.02.18.02.12.12
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Feb 2013 02:12:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130218091619.GC5096@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216465>

Jeff King wrote:

> Originally we had a single function for reading packetized
> data: packet_read_line. Commit 46284dd grew a more "gentle"
> form that would return an error instead of dying upon
> reading a truncated input stream. However:

In other words:

	Based on the names of two functions "packet_read" and
	"packet_read_line", it is not obvious which to use and what the
	ramifications of that choice are.

	Rename packet_read to packet_read_line_gently and add a comment
	explaining that the latter is a "gentler" form that returns an
	error instead of dying upon reading a truncated input stream.

	While at it:

	 * Rename the internal argument triggering the gentle mode to
	   "gentle" instead of "return_line_fail".

	 * Drop the redundant "return_line_fail &&" in checks like
	   "if (return_line_fail && ret < 0)".  safe_read() never
	   returns an error when !gentle.

	No functional change intended.

FWIW, the patch itself is
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
