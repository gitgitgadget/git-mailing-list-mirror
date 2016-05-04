From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] bisect: rewrite `check_term_format` shell function
 in C
Date: Wed, 4 May 2016 13:13:18 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605041309430.9313@virtualbox>
References: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com> <1462338472-3581-1-git-send-email-pranit.bauva@gmail.com> <1462338472-3581-3-git-send-email-pranit.bauva@gmail.com> <CAPig+cRL7QkQHpSmeKEYECd9JQO8B29OOJoGx2AQORPfmW7QQQ@mail.gmail.com>
 <CAFZEwPNKug1pvGC1fTvZzVPBGKy71fw6S3qcx_fx98nYZasR3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	christain.couder@gmail.com,
	Lars Schneider <larsxschneider@gmail.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 13:13:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axukF-0007Bw-G8
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 13:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757270AbcEDLN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 07:13:26 -0400
Received: from mout.gmx.net ([212.227.17.22]:52586 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757197AbcEDLNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 07:13:25 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MS0c2-1b51Te0iFO-00THLK; Wed, 04 May 2016 13:13:20
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAFZEwPNKug1pvGC1fTvZzVPBGKy71fw6S3qcx_fx98nYZasR3w@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:UIBFxLvdMzqrcbuva6q7vbf57gpPObWzWpUxjQSBXWedhJBd3gZ
 nVCWJD6pxVzdbTmqRafUT8YUxLZJ9ZUXLZgzbFUQr6kkxoyMdJEtg965uSC8f4vOhi4nBeX
 efAF1MUt3IKAaLhyn47Tpn4eRkcuE9rtG3+lAHce2FuvEbR8MPBueP/WdBv0it5DiE/6yMt
 hvnjfNE9Pd/tswdm1Gurg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mOqi9u6W90Y=:UhsxDWp2DSzUNjDOMwA+hW
 /pdS1cRF4kW9w2CW0rRPKlaYe8e5tl+gy4jeYIwyj4Os4vDiGngIAWQtHs3Jndz3kzjwIVKhs
 yVjb5dTBsq9Yd0BoVHtC/+s3REidU85LrJHIawHwA++FN/zMLkjgiEFnhThsMzFCodCtYx8ld
 LSRhKZwcmmx4mg/4q0n4wY+ziDcscDVHUo8zla24kKnC7feetNFAMtXALy8pq1fdTXgnbF2qC
 dBoOVkeMfhQYLS4ykJdMLWsnpP35FG1KrtG7dm2ihZYufCT+KHa7T0j0dHa3yLm5FP6Lh3D+n
 xYjLP5c1bbpJ3BAQBqtweKlgj12TNQxdwsT5Xfng6h5JjS784WsQi7SaMZCRgaofjz7yfiBOY
 t3t04+HQS2Y1c8gTxSNTfSbavnamgs23Ip4+D6l6W5SDeUt5UgBysuoAmv916k/L7J8ns14Ik
 Nu3y7OC9th4gMJlpTPa8LKjtF10/oFrdRWYJl515JwRDAU97jsuEONjq2b7MvKMArbf8bU/XP
 V3uViRQRakxR1rnsa2/ijv9BN6rsBGglsbUsNXTMzokwYZ82V6Vh8MTNbMTlHkPp3oycbM+Js
 OpZdfjP4ZRCL/YZC3TgJ3rrPO/4TrOJLFERp4mYcC+lQQxWEZmTD7AuNwnDa6WS2941QxpIko
 M6htegNcJ34XQ5xoW88l49/5FAs7SZ9fASM2FsvHN/5wzfKkAvg4gVUMY9s+dILnYyKy/b2Aw
 QUUtFakQi88m06tfErL071YMZm3oU6+U5mcku/NI9au8Jj/WdmG3EMavGjcsVa9fpJGRUQHB 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293533>

Hi Pranit,

On Wed, 4 May 2016, Pranit Bauva wrote:

> On Wed, May 4, 2016 at 12:22 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Wed, May 4, 2016 at 1:07 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> >
> >> +static int one_of(const char *term, ...)
> >> +{
> >> +       va_list matches;
> >> +       const char *match;
> >> +
> >> +       va_start(matches, term);
> >> +       while ((match = va_arg(matches, const char *)) != NULL)
> >> +               if (!strcmp(term, match))
> >> +                       return 1;
> >
> > Is it wise to return here without invoking va_end()?
> 
> I guess since it already checks for NULL, invoking va_end() will make
> it redundant[3].

Actually, this is my fault (I suggested that form of the one_of()
function). The man page for va_end() clearly states that every call to
va_start() needs to be paired with a corresponding va_end(), so it is
incorrect to return without a call to va_end().

Maybe something like instead?

	static int one_of(const char *term, ...)
	{
		int res = 0;
		va_list matches;
		const char *match;

		va_start(matches, term);
		while (!res && (match = va_arg(matches, const char *)))
			res = !strcmp(term, match);
		va_end(matches);

		return res;
	}
Ciao,
Dscho
