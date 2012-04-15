From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v3 1/5] completion: simplify __gitcomp_1
Date: Sun, 15 Apr 2012 11:33:34 +0200
Message-ID: <20120415093334.GB2900@goldbirke>
References: <1334439784-6460-1-git-send-email-felipe.contreras@gmail.com>
	<1334439784-6460-2-git-send-email-felipe.contreras@gmail.com>
	<87obqueyas.fsf@thomas.inf.ethz.ch>
	<CAMP44s3qXnONLh_=gO4_9DK2=bx0tLBTTAb4WenYh5k2QPQL-g@mail.gmail.com>
	<CAMP44s05KsZFAW=i7TvN0jDNPyFZ4OHkOTwVp2+04CR-jsz-nA@mail.gmail.com>
	<m2ehrpcs9u.fsf@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Apr 15 11:33:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJLqD-0002oY-6Q
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 11:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754294Ab2DOJdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 05:33:43 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:56113 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142Ab2DOJdm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 05:33:42 -0400
Received: from localhost6.localdomain6 (p5B13091B.dip0.t-ipconnect.de [91.19.9.27])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0MCk6A-1SRdYj1Quo-008pNK; Sun, 15 Apr 2012 11:33:36 +0200
Content-Disposition: inline
In-Reply-To: <m2ehrpcs9u.fsf@linux-m68k.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:yhVn5SyTkvE0vyuGLN1x+I2ZwJoBK/8FPQC4i8xjoQi
 XRehLI9Si4uG5UGEkUBq/afLvMhsybjqtjLvMj6NacO8cNKeQ6
 My0iW9mfqIOppzJDOj+vDk+3CDW6HRNirPsn3L5LcEWE972rp1
 plmt7OtD5NN8s7MQ8ARayFS1VnOEiTtaCyaP38UEMtttfhanM9
 IQ8fBu0+wokapGZ0iPr/63oEP0eaJMSbBP2O4JMstIwW4446RL
 1D0q5RFlxYnARszvmJWx+9dqyJSN3aUNINp4jHJ7VgzpSHx+yQ
 ghVx6Mthm7Hb2EYdrpOK7jqXDI9DR+Dizxzeu7VHHmzwWcxGtP
 hFD8pVzSKOgKl3ZeiNIg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195550>

On Sun, Apr 15, 2012 at 10:29:17AM +0200, Andreas Schwab wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > However, I would like to simplify it even more:
> >
> > __gitcomp_1 ()
> > {
> > 	local c w s IFS=' '$'\t'$'\n'
> > 	for c in $1; do
> > 		w="$c$2"
> > 		case "$w" in
> > 		--*=*|*.) s="" ;;
> > 		*)        s=" " ;;
> > 		esac
> > 		printf "%s$s\n" "$w"
> > 	done
> > }
> 
> Or even:
> 
> __gitcomp_1 ()
> {
> 	local c IFS=$' \t\n'
> 	for c in $1; do
> 		c=$c$2
> 		case $c in
> 		--*=*|*.) ;;
> 		*)        c="$c " ;;
> 		esac
> 		printf '%s\n' "$c"
> 	done
> }

We can even get rid of the %s with

  printf -- "$c\n"
