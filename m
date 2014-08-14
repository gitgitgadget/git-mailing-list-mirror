From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] fetch: convert argv_gc_auto to struct argv_array
Date: Thu, 14 Aug 2014 15:53:20 -0400
Message-ID: <20140814195320.GA19337@peff.net>
References: <1408017065-17437-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mflaschen@wikimedia.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 21:53:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XI15S-0005eG-EO
	for gcvg-git-2@plane.gmane.org; Thu, 14 Aug 2014 21:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447AbaHNTxW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2014 15:53:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:52030 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752444AbaHNTxW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2014 15:53:22 -0400
Received: (qmail 26724 invoked by uid 102); 14 Aug 2014 19:53:22 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Aug 2014 14:53:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Aug 2014 15:53:20 -0400
Content-Disposition: inline
In-Reply-To: <1408017065-17437-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255273>

On Thu, Aug 14, 2014 at 06:51:04PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> -	static const char *argv_gc_auto[] =3D {
> -		"gc", "--auto", NULL,
> -	};
> +	struct argv_array argv_gc_auto =3D ARGV_ARRAY_INIT;
> =20
>  	packet_trace_identity("fetch");
> =20
> @@ -1198,7 +1196,8 @@ int cmd_fetch(int argc, const char **argv, cons=
t char *prefix)
>  	list.strdup_strings =3D 1;
>  	string_list_clear(&list, 0);
> =20
> -	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
> +	argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);
> +	run_command_v_opt(argv_gc_auto.argv, RUN_GIT_CMD);

argv_array_clear() here afterwards?

Not a huge deal since we are about to exit, but in the name of
good hygiene.

-Peff
