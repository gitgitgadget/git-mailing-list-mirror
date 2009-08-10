From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/8] wt-status: move wt_status_colors[] into
 wt_status structure
Date: Mon, 10 Aug 2009 05:12:50 -0400
Message-ID: <20090810091250.GB7513@coredump.intra.peff.net>
References: <1249894465-11018-1-git-send-email-gitster@pobox.com>
 <1249894465-11018-2-git-send-email-gitster@pobox.com>
 <1249894465-11018-3-git-send-email-gitster@pobox.com>
 <1249894465-11018-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 11:13:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaQw7-00065J-4x
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 11:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706AbZHJJMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 05:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752677AbZHJJMv
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 05:12:51 -0400
Received: from peff.net ([208.65.91.99]:48853 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752377AbZHJJMu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 05:12:50 -0400
Received: (qmail 13266 invoked by uid 107); 10 Aug 2009 09:12:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 10 Aug 2009 05:12:51 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Aug 2009 05:12:50 -0400
Content-Disposition: inline
In-Reply-To: <1249894465-11018-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125425>

On Mon, Aug 10, 2009 at 01:54:20AM -0700, Junio C Hamano wrote:

> @@ -37,6 +38,7 @@ struct wt_status {
>  	int wt_status_relative_paths;
>  	int wt_status_submodule_summary;
>  	enum untracked_status_type show_untracked_files;
> +	char wt_status_colors[6][COLOR_MAXLEN];

Yuck on the magic "6". It should be safe to use

  ARRAY_SIZE(wt_status_colors_default)

since that is computed purely from sizeof's. Though I am not discounting
the possibility that there are compilers which will screw it up.

-Peff
