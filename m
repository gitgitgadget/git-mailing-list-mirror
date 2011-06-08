From: =?ISO-8859-1?Q?J=E9r=E9mie_NIKAES?= <jeremie.nikaes@gmail.com>
Subject: Re: Git-mediawiki : Encoding problems in perl
Date: Thu, 9 Jun 2011 00:36:58 +0200
Message-ID: <BANLkTikTDPmvj4oepiJdFj9EpSTNpS_Prg@mail.gmail.com>
References: <BANLkTimy85b3nu05FBjXzdnTJP0RBWdxiQ@mail.gmail.com>
 <20110608150106.GB7805@sigill.intra.peff.net> <vpqhb8049m3.fsf@bauges.imag.fr>
 <BANLkTi=DLZQM_jzove_g0wLy_zgBF6Z0Xw@mail.gmail.com> <vpqtyc0wc1j.fsf@bauges.imag.fr>
 <BANLkTinKV3k7uu=+QzvUjrLdRD0TUj67pw@mail.gmail.com> <vpqsjrkqmdj.fsf@bauges.imag.fr>
 <BANLkTinE9+1cVk09KCP-iW=+GFbRdDAZFg@mail.gmail.com> <20110608215130.GA13021@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, thomas@xteddy.org,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 09 00:37:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QURNM-0005sU-Jc
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 00:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755011Ab1FHWhU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2011 18:37:20 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54179 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104Ab1FHWhS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2011 18:37:18 -0400
Received: by pvg12 with SMTP id 12so457394pvg.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 15:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=YpB4P/KmNIMJgZg+N9z2qqun26BO7RddtgbIgDz+8C4=;
        b=HFAvZNTfbwdULQ4aD5pewv4+H0bSrOYL5AWD/gpW3ghPIp35Fgu5/4h5EC7pvF8SGh
         sB/lRHqbqTPEjuBJixjzRIiD6MaYwsy2MpV3LJjiufQY6PzStpFmpy2RjEPFUTgyZHG0
         sIZPFQZjJDEXOK1pnM8yk2MgzrTQkgTufXehM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=TMBBXo2Fkgz70c68G/XiruDgE0vFlLvKgfNrl2PIbXyZAFuiRg23SkklX0fx8Nv/80
         e7299gtYe2UPVc6rgcAnexZAi2WXsje58tLth/SJrmUtSbAp9g81lrH6E2PcUjZJnR7i
         L4pXUHD3j96WcCAzRBpwXJiA3CdHoroaPDaHI=
Received: by 10.68.44.130 with SMTP id e2mr1061875pbm.515.1307572638327; Wed,
 08 Jun 2011 15:37:18 -0700 (PDT)
Received: by 10.142.136.2 with HTTP; Wed, 8 Jun 2011 15:36:58 -0700 (PDT)
In-Reply-To: <20110608215130.GA13021@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175471>

2011/6/8 Jeff King <peff@peff.net>:
>
> But if you are parsing "diff", then yes, filenames with high-bit
> characters (or special characters like tab or double-quote) may be
> quoted C-style, and you should be unquoting them. Or, as Matthieu
> suggested, use "-z" to get a NUL-terminated, non-quoted version.

Yes, we are parsing "diff". The -z helped a lot with non-iso characters=
=2E
Everything seems to be working fine now without using uri_escape. The
problem is, as Matthieu said, different file systems may handle these
characters in file names differently, so in the long run it could be
better to use uri_escape / uri_unescape.

The problem I run into now is that we are using
use encoding 'utf-8'
as Jakub suggested.
Using this mode, when you uri_escape and uri_unescape a string, you
don't get the original string. I must be missing something but my head
is kind of fuzzy with all the different existing methods to encode
things in utf8 and it is getting pretty late.

Thanks a lot to everyone who helped today, a RFC patch should follow to=
morrow.

--=20
J=E9r=E9mie Nikaes
