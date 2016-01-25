From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 09/19] mingw: accomodate t0060-path-utils for MSYS2
Date: Mon, 25 Jan 2016 16:39:45 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601251638580.2964@virtualbox>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <12c030323940de4a0845eda9bdd7b67c4e90864a.1453650173.git.johannes.schindelin@gmx.de> <56A52B28.8010304@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Jan 25 16:40:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNjFS-00056c-Jr
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 16:40:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757389AbcAYPkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 10:40:00 -0500
Received: from mout.gmx.net ([212.227.17.21]:49158 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753549AbcAYPjz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 10:39:55 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MZPer-1age4d0a33-00LH0n; Mon, 25 Jan 2016 16:39:46
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <56A52B28.8010304@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:fSxqHZHJIjPnZejAPnXdI9Of0tGDO8FHtT7Lz6cXvcqKLAxBhRf
 FKSGreQ9leimjcaKN4zcQDm1lQQkWIBN0i+xfWZxByqEsez/KZKIZIq6RmBQx2DZlwqoniJ
 pqgTSS2S7Yevw+ilKvBONb/bytp2KzjPo6SlCcAUAMWTdOw3BIZthZRrX+LZHWNZWNBjYco
 d3bXbz/QK55Y+HVo5C96g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SgmGNGWDh5c=:oAyj8xBm85ycC37TB5JN/a
 6txTbhyhQW1psHPEMRJmYASyVEXK/lISLOY96yACBVlvDTB2Epcp4yVOKv1okJ/QkV7qkYlO/
 f56dz7QLocHJDfdyQlU+NrUMvKFk0DUBV6yfYVJfaCzT2oqJVBgHhIpgQOXovaZ+TxjERK8Su
 MZDMYeUrYD77jeEC1vj1T13MadjHtztj8eDdJPVFpAu0YNhmRqrcytUND9TMq4ZmmRuNL5K4y
 l8DesHuI3+lgXLFrKKqpRsE9JbTJlvrdFw1feR7XdkUSDljJXs21J4yfml+B/sY3iKdTAnwfL
 cq517p25G7ovPC4vvy9r3A27148A9lCGkE2nw/6OX2cdMppGuB+RbKg2uOxTmTO0emmBIZmA0
 KNktJeh0K961CX1covFNFYC4xnfpKLmL8x2f3vNIOk2xk+4dvgYvOm2HXPoVlVlsrUIFA91+s
 O8lTb6B1MJk8n4o7Zm+gT0CgHeeSv9qdMPT2+ouSIoGBWuAcouda2RVExTbcm1KpgV4X1sGA4
 D57JRw2L5CIUDHRDNivOWXOuPOnzqkymekWoK4vmK+ofoxgSBuovarcAgUu09bu5D7Fu7uuW/
 d8xvUeZOEN6tqp8HnlFTxcIs8Zc0XnB0A+nfJTFWniFPZnee8Z0y7ztVcjBuqt1u7szi8lMJc
 ctL4j6trsKbU4U3e5nSRWrlg0zXnWYu8q19xcFC5/973G0ndDTFLhHomv+nI9uSNjWioXF7w9
 Ri/XJj1YfguLhlVJxN5vzqo7Dp/nyiS2BgWlwVtL35br2pEZQHfF9VRDSg48F0D4gAhVZCTl 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284735>

Hi Hannes,

On Sun, 24 Jan 2016, Johannes Sixt wrote:

> Am 24.01.2016 um 16:44 schrieb Johannes Schindelin:
> > On Windows, there are no POSIX paths, only Windows ones (an absolute
> > Windows path looks like "C:\Program Files\Git\ReleaseNotes.html", under
> > most circumstances, forward slashes are also allowed and synonymous to
> > backslashes).
> > 
> > So when a POSIX shell (such as MSYS2's Bash, which is used by Git for
> > Windows to execute all those shell scripts that are part of Git) passes
> > a POSIX path to test-path-utils.exe (which is not POSIX-aware), the path
> > is translated into a Windows path. For example, /etc/profile becomes
> > C:/Program Files/Git/etc/profile.
> > 
> > This path translation poses a problem when passing the root directory as
> > parameter to test-path-utils.exe, as it is not well defined whether the
> > translated root directory should end in a slash or not. MSys1 stripped
> > the trailing slash, but MSYS2 does not.
> > 
> > To work with both behaviors, we simply test what the current system does
> > in the beginning of t0060-path-utils.sh and then adjust the expected
> > longest ancestor length accordingly.
> > 
> > Originally, the Git for Windows project patched MSYS2's runtime to
> > accomodate Git's regression test, but we really should do it the other
> > way round.
> > 
> > Thanks to Ray Donnelly for his patient help with this issue.
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >   t/t0060-path-utils.sh | 37 ++++++++++++++++++++++---------------
> >   1 file changed, 22 insertions(+), 15 deletions(-)
> > 
> > diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> > index f0152a7..89d03e7 100755
> > --- a/t/t0060-path-utils.sh
> > +++ b/t/t0060-path-utils.sh
> > @@ -7,6 +7,13 @@ test_description='Test various path utilities'
> >   
> >   . ./test-lib.sh
> >   
> > +# On Windows, the root directory "/" is translated into a Windows directory.
> > +# As it is not well-defined whether that Windows directory should end in a
> > +# slash or not, let's test for that and adjust our expected longest ancestor
> > +# length accordingly.
> > +root_offset=0
> > +case "$(test-path-utils print_path /)" in ?*/) root_offset=-1;; esac
> > +
> >   norm_path() {
> >   	expected=$(test-path-utils print_path "$2")
> >   	test_expect_success $3 "normalize path: $1 => $2" \
> 
> In t0060-path-utils.sh, I currently find this:
> 
> # On Windows, we are using MSYS's bash, which mangles the paths.
> # Absolute paths are anchored at the MSYS installation directory,
> # which means that the path / accounts for this many characters:
> rootoff=$(test-path-utils normalize_path_copy / | wc -c)
> # Account for the trailing LF:
> if test $rootoff = 2; then
> 	rootoff=	# we are on Unix
> else
> 	rootoff=$(($rootoff-1))
> fi
> 
> ancestor() {
> 	# We do some math with the expected ancestor length.
> 	expected=$3
> 	if test -n "$rootoff" && test "x$expected" != x-1; then
> 		expected=$(($expected+$rootoff))
> 	fi
> 	test_expect_success "longest ancestor: $1 $2 => $expected" \
> 	"actual=\$(test-path-utils longest_ancestor_length '$1' '$2') &&
> 	 test \"\$actual\" = '$expected'"
> }
> 
> Furthermore, since you are modifying only cases where the expected
> value is not -1 and we already have a check for this case in the
> helper function, wouldn't it be simpler to merge the offset that your
> case needs with the one that we already have?

Good points. I reworked the patch here (will be part of v2):
https://github.com/dscho/git/commit/24767bd

Ciao,
Dscho
