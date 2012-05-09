From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 11/19] bash prompt: use bash builtins to find out
	current branch
Date: Wed, 9 May 2012 23:45:34 +0200
Message-ID: <20120509214534.GF6958@goldbirke>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
	<1336524290-30023-12-git-send-email-szeder@ira.uka.de>
	<7vzk9hqg0u.fsf@alter.siamese.dyndns.org>
	<20120509211143.GE6958@goldbirke>
	<7vehqtqc6d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 09 23:45:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSEhZ-0002Kf-I5
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 23:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234Ab2EIVph convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 17:45:37 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:49179 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756451Ab2EIVpg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 17:45:36 -0400
Received: from localhost6.localdomain6 (p5B1303EC.dip0.t-ipconnect.de [91.19.3.236])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0LjsL3-1Rqz4O3Sg5-00bULs; Wed, 09 May 2012 23:45:34 +0200
Content-Disposition: inline
In-Reply-To: <7vehqtqc6d.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:fOsPKRGTliO2TMITQVVGPf35ZKCQcbj0geyfjAfSMoC
 lsMOAafopGAxz429yur9vldShjbtkP95BevN5f/EvN2cPWeDKM
 F1nMtNnvne3HWRy3wta/yKquvIv0aoObdSblj4IEvg7NyklKNR
 IDucxjYDnay8ya7HRSFIzTq7izRt5m9YflBDIgxW1WxZTl9Pol
 TGcn8G1eYNe0Qqet1mnELZvEoWucrCuf8PJNyiygPX+nMIQH7a
 BOIvatqvfINlqaqpfsu1RkWbJZ+uLuv53kpw6WSbSPBHJq0+C/
 My0kD+4/BcROPz4e8eFW54tnyxBFhX/F2T6d4bWicaopqX+USb
 nFImuiB58P4CPhysLq64=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197519>

On Wed, May 09, 2012 at 02:25:46PM -0700, Junio C Hamano wrote:
> SZEDER G=E1bor <szeder@ira.uka.de> writes:
>=20
> > If the above is right, then we could check with bash builtins wheth=
er
> > HEAD is a symbolic link, which is cheap, and stick to '$(git
> > symbolic-ref HEAD)' if it is, or use bash builtins if it isn't, rig=
ht? =20
>=20
> Sure.  Alternatively, you could run "readlink" on it if that is avail=
able
> built-in, and manipulate the result in string builtins, but that is a=
 b/c
> slow path anyway, so I wouldn't bother.

OK, will do that then.

'readlink' is not a bash builtin, so it would need the same number of
fork()s and exec() as 'symbolic-ref'.  Of course, the 'readlink'
binary is much smaller than git and has less to do, so it might be a
tiny bit faster, but for this rare corner case it really doesn't
matter.
