From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] merge-file: consider core.crlf when writing merge
 markers
Date: Wed, 25 Nov 2015 12:09:17 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1511251205430.1686@s15462909.onlinehome-server.info>
References: <1448314332-15581-1-git-send-email-dev+git@drbeat.li> <alpine.DEB.1.00.1511240844380.1686@s15462909.onlinehome-server.info> <5654E7FD.2060000@drbeat.li> <5654E9B6.3090801@drbeat.li>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Beat Bolli <dev+git@drbeat.li>
X-From: git-owner@vger.kernel.org Wed Nov 25 12:09:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1Xx2-0002pu-Iy
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 12:09:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364AbbKYLJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 06:09:24 -0500
Received: from mout.gmx.net ([212.227.17.22]:62241 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751609AbbKYLJV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 06:09:21 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0Lkwpt-1aZECp0SKz-00amCE;
 Wed, 25 Nov 2015 12:09:18 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <5654E9B6.3090801@drbeat.li>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:7eR5RpBGgQHwMg5pPHxuzn2mvNzw8KQPVxJSWUW1sCyoWwcFhbS
 SqM4vLjMveU+SHrVk/qqNzhejQXkW2slSqtlm3hhjPCySU9wABUrXFI4hSlehJzTXwxBuYB
 l9O8ztX3b0CvEoI/ez2L2r11Ya2lO/VQ7LB1Eav0qHI/8qz5vUrgp/mb3hLM7InLAT6ca0y
 IZNC2+dd0o+X/jcDmVHgw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bW33cBeOjng=:JCo+DbRYFB9j1HpuZJ1cGs
 e+W4U/sa+YkJsIXIKcc1tmVIMiIrS8GdzvxFwbftn4gd46F4SLdHbnsYji/WoAwqkwIFt/uYn
 e4asIhZhRLQT2yiWvI9dd//U9km2Sf/2TPsDMCl8b7DtArFtcVSygK5xQC2TAjFC83OsgH4qq
 h8cDID0ulV2q6LDVoUp8s7LinuhvwCqKe3u75RoqF/FSXGvx6qq+udPbmFvobkkVQfJqgfkEk
 QogvoW3nKXO3N10YB50H9uh+CYyM2HNOU1sYvTDpcSvnZAFX29WGu8PGzrzfAEG0zdvdifghf
 AYNLgYFcWExReVpwFR85aXgIRgsvKeuqWkckOziIPZ52M0BtEg7GB4Hym4y6PXLqkGNrMX/KB
 xYFYq6eqDjUl+wrp48LKDQR7hISwlEqQK1qVKbLI/2HQlleD7dxd45L+dzer8RZhQ+NW2Qmyv
 QRIhmalhSlBlcTWHfvciFEEh19OU4Bj2sPN4rzIB4XbJ1thUHMy4wp8hwbq7f28Pz28JDHbZY
 Os/IOQTKShRPH56DIFE3Ca5uJJHKfy9vHomaBY6+D+ieE0LRBiXUFkkdXL55h10jJE7u6WDHB
 Uiw136vAgEshrrzvdFQ+fWdB22ijpGGiZnmyPFA/6kepZTXWe0Ag2niQSVdGu0kFgqparOxkr
 M1HaXq6aj8Ifta+k8sycY6E8YC2Wd5qfajI/oqGUtoYi6JNdgll0qvZSo+6A3PE71+GfCwNR4
 g/VBl/Op52JEHRXe+P5u4Pb5gankWgKguHkruViJO0EMRmdxU/D3lvGaioRft0K9TY9pHdtZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281701>

Hi Beat,

On Tue, 24 Nov 2015, Beat Bolli wrote:

> On 24.11.15 23:43, Beat Bolli wrote:
> > On 24.11.15 09:21, Johannes Schindelin wrote:
> >>
> >> On Mon, 23 Nov 2015, Beat Bolli wrote:
> >>
> >>> When merging files in repos with core.eol = crlf, git merge-file
> >>> inserts just a LF at the end of the merge markers. Files with mixed
> >>> line endings cause trouble in Windows editors and e.g.
> >>> contrib/git-jump, where an unmerged file in a run of "git jump
> >>> merge" is reported as simply "binary file matches".
> >>
> >> Wow, what a beautiful contribution!
> >>
> >> I wonder how difficult it would be to make this work with
> >> gitattributes, i.e. when .gitattributes' `eol` setting disagrees with
> >> core.eol.
> > 
> > I have implemented this according to your algorithm. Now, I have to
> > set core.autocrlf to true for making the new test pass. Setting
> > core.eol no longer has an effect on the merge markers. Is this
> > expected? (I haven't set any attributes)
> 

No, this is not expected. I guess that I was a bit careless in my
suggestion (it was just a sketch, after all, not a full implementation):

> enum eol eol_for_path(const char *path, const char *src, size_t len)
> {
>         struct conv_attrs ca;
>         struct text_stat stats;
> 
>         convert_attrs(&ca, path);
>         if (output_eol(ca.crlf_action) != EOL_CRLF)
>                 return EOL_LF;

At this point, output_eol(ca.crlf_action) would be EOL_UNSET, I guess, in
which case we would have to consult core_eol, of course. So it is not
enough to test for EOL_CRLF but we really need to test for EOL_CRLF,
EOL_LF and EOL_UNSET explicitly (I would use a switch() statement and use
a default: rule instead of handling EOL_UNSET specifically).

Ciao,
Dscho
