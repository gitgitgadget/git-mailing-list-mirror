From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/3] fetch-pack: use index-pack --unpack-limit instead
 of unpack-objects
Date: Sun, 8 Sep 2013 00:45:32 -0400
Message-ID: <20130908044531.GE14019@sigill.intra.peff.net>
References: <1378091107-31682-1-git-send-email-pclouds@gmail.com>
 <1378428363-14086-1-git-send-email-pclouds@gmail.com>
 <1378428363-14086-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 06:45:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIWsW-00039Z-0a
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 06:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420Ab3IHEpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 00:45:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:42204 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023Ab3IHEpf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 00:45:35 -0400
Received: (qmail 32246 invoked by uid 102); 8 Sep 2013 04:45:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 07 Sep 2013 23:45:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Sep 2013 00:45:32 -0400
Content-Disposition: inline
In-Reply-To: <1378428363-14086-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234179>

On Fri, Sep 06, 2013 at 07:46:02AM +0700, Nguyen Thai Ngoc Duy wrote:

>  static int get_pack(struct fetch_pack_args *args,
> -		    int xd[2], char **pack_lockfile)
> +		    int xd[2], char **pack_lockfile_p)
>  {
>  	struct async demux;
> -	const char *argv[22];
> +	const char *argv[23];
>  	char keep_arg[256];
> -	char hdr_arg[256];
> +	char unpack_limit_arg[256];

Perhaps it is time to convert this to use argv_array? I think you could
even get rid of the fixed-size buffers, too, with argv_array_pushf().

-Peff
