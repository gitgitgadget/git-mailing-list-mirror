From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC v3 0/4] Improving performance of git clean
Date: Tue, 21 Apr 2015 17:24:27 -0400
Message-ID: <20150421212427.GB13230@peff.net>
References: <1429389672-30209-1-git-send-email-erik.elfstrom@gmail.com>
 <20150420221414.GA13813@hank>
 <CAMpP7NaUv10Ox0gNsE8cg4hUnNNiFi8NZSLw6F6SW+SLrt0VwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gummerer <t.gummerer@gmail.com>,
	Git List <git@vger.kernel.org>
To: erik =?utf-8?B?ZWxmc3Ryw7Zt?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 23:24:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ykfel-0002mF-5W
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 23:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620AbbDUVYa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Apr 2015 17:24:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:48289 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932539AbbDUVYa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 17:24:30 -0400
Received: (qmail 5176 invoked by uid 102); 21 Apr 2015 21:24:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Apr 2015 16:24:30 -0500
Received: (qmail 4803 invoked by uid 107); 21 Apr 2015 21:24:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Apr 2015 17:24:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Apr 2015 17:24:27 -0400
Content-Disposition: inline
In-Reply-To: <CAMpP7NaUv10Ox0gNsE8cg4hUnNNiFi8NZSLw6F6SW+SLrt0VwQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267555>

On Tue, Apr 21, 2015 at 08:21:37PM +0200, erik elfstr=C3=B6m wrote:

> Ok, thanks for looking into this.
>=20
> I have no well founded opinions on the implementation but I do
> think the performance tests would be more meaningful if the
> setup/cleanup code could be removed from the timed section.
> If the community agrees on an implementation I would be happy
> to convert the new tests, either directly in this series or as a foll=
ow
> up if that is preferred.

If I understand correctly, the reason that you need per-run setup is
that your "git clean" command actually cleans things, and you need to
restore the original state for each time-trial. Can you instead use "gi=
t
clean -n" to do a dry-run? I think what you are timing is really the
"figure out what to clean" step, and not the cleaning itself.

-Peff
