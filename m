From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Should the --encoding argument to log/show commands make any
 guarantees about their output?
Date: Mon, 15 Jun 2015 18:21:40 +0200
Message-ID: <557EFB94.3040104@web.de>
References: <557E91D2.3000908@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Jan-Philip Gehrcke <jgehrcke@googlemail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 15 18:21:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4X91-0007vI-Qv
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 18:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756041AbbFOQVt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jun 2015 12:21:49 -0400
Received: from mout.web.de ([212.227.17.12]:59358 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755792AbbFOQVp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 12:21:45 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MduMb-1YfQ2i3qNJ-00Peop; Mon, 15 Jun 2015 18:21:42
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <557E91D2.3000908@googlemail.com>
X-Provags-ID: V03:K0:3MYlgQ1+1Ti7ZxJFSC3J7D2JcI75KGBudt6SeEw65+ZYQpKZt8V
 INmXYHOmkEhje0e8qRj14VdklGao+RZyX7ARxS4MhgeCOC7vRkzjwvHtph8PmiTxKwpOK99
 4KlWhvMMzdeFISU71Eab/RJZ+jkzMiThR3ZTBmb0cX+VsjJNUQ3X7CsJReCZ/ShhUmKLey4
 Qnznqb2tNByPJkIOE1K0Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6yvD9lI5xEw=:5+prLyfQh58XCk/JvSl/GU
 uHxgk/RCS6tVDQu5OStex6VOP5/srZLvp+Nwkc2xC1xMUD1IDMN2aHjlMTdjRZtrZE9995oez
 Na47SHji1adUxLkw/zJ2RwmQK9B5/EeW3jbTOswQh2ChleHF07UFSpQAlmsEZdN9vWdSBiX5h
 a+iwPzOuHXr7Wlq0TMlm0xyQYd4F0MvQKJyifmbbF5BuF/SI/yCz/ywUL+O8+FXxB4p71jDkt
 Yz2dbcU/Gpoo2RGgZfWyBZ3Fq2ibuJsRmua6BXAt1Ttle0zQcoJY5PU/g7H3z9psMiEopFhua
 mBDF/KXDj+poPa2YL/25enxr1xrRDoRnyZOLLeAV6msKumTvQhF+g4ndptHqznL3BzY3p9be9
 j/2vCMxSEs5zxsmyBGnO6ptfwvX0wkY9Dk18M0T/ChXBzEuQ1YGO+ImN9leE94UrqKlMg/XXk
 wTk5w8xlNsHELH210nl7u1CLIOYc/Dr3hcW/AfIkVob9umHpjl48oWAbJtgFuz9u9xqAIWbbi
 aJa9acGujrdHktcJYLC12n67TfQqZuC0ltgnvzSXFuKY+zPAM5oCPO9MPo0fmjIIxLiGbycAV
 RRD3soUYeza9sfohxzs1uLCfxvHVbyEDjgacRDzO7JyAM2IWrBesg7tcYErcUI9Cu6Cvpk8CY
 sfN44GkiS1W2M2OjKlE4c6OztuZ7eFZ06re9fmak8wXJElkMB4Ni53uCzkvOFX1suXcg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271688>

On 2015-06-15 10.50, Jan-Philip Gehrcke wrote:
> Hello,
>=20
> I was surprised to see that the output of
>=20
>     git log --encoding=3Dutf-8 "--format=3Dformat:%b"
>=20
> can contain byte sequences that are invalid in UTF-8. Note: I am usin=
g git 2.1.4 and the %b format specifier represents the commit message b=
ody.
>=20
> I have seen this with the Linux git repository and the following test=
:
>=20
>     git log --encoding=3Dutf-8 "--format=3Dformat:%b" | python2 -c \
>         'import sys; [l.decode("utf-8") for l in sys.stdin]'
>=20
> Soon enough errors like this appears:
>=20
>     'utf8' codec can't decode byte 0xf6 in position 19
>=20
> The help message to the --encoding argument reads:
>=20
>> The commit objects record the encoding used for the log message in
>> their encoding header; this option can be used to tell the command t=
o
>> re-code the commit log message in the encoding preferred by the user
>=20
> I realize that this message does not give any guarantee about the out=
put of the command, in the sense that --encoding=3Dutf-8 produces valid=
 UTF-8 data in all cases.
>=20
> However, I wonder what --encoding precisely does and if it has the be=
havior most users would expect.
>=20
> Let me describe what I think it currently does:
>=20
> The program attempts to re-code a log message, so it follows the chai=
n
>=20
>     raw input -> unicode -> raw output
Not sure what "raw input/output" means.
But there is only one reencode step involved, e.g.
input(8859) -> output(UTF-8)
When the encoding of the commit message is undefined, UTF-8 is assumed.
But Git does no verify if the encoding is really UTF-8.
We could guess that if it is not UTF-8 then it is ISO-8859-1, but that =
is not implemented.

>=20
> For the first step, knowledge about the input encoding is required.=20
When someone does a commit where the commit message does not conform to=
 UTF-8,
This message is shown from Git:
"Warning: commit message did not conform to UTF-8.\n"
"You may want to amend it after fixing the message, or set the config\n=
"
"variable i18n.commitencoding to the encoding your project uses.\n";

If the user ignores this warning, how should Git guess the encoding  ?
(Later Git versions try do an auto-conversion assuming ISO-8859-1) ,
but that doesn't help real existing repos.

> This is retrieved from the encoding header of the commit object if pr=
esent or (from the docs)=20
>"lack of this header implies that the commit log message is encoded in=
 UTF-8."=20
>If this step fails (if the entry contains a byte sequence that is inva=
lid in the specified/assumed input codec),=20
>the procedure is aborted and the data is dumped as is (obviously witho=
ut applying the requested output encoding).
>=20
> Is that correct?
Yes, see above.
>=20
> From my point of view the most natural abstraction of a log *message*=
 is *text*, not bytes.=20

>The same is true for author names.=20

>If I want to build a tool chain on top of log/show, this usually means=
 that I want to work with text information.=20
>Hence, I want to retrieve text (a sequence of code points) from git sh=
ow/log.=20
>Text must be transported in encoded form, sure,=20
>but it must not contain byte sequences that are invalid in this codec.=
=20
>Because otherwise it's just not text anymore.
>=20
Call it corrupted.
> Hence, from my point of view, the rational that git show/log should b=
e able to output *text* information means
> that they should not emit byte sequences that are invalid in the code=
c specified via the --encoding argument.=20
> In the current situation, the work of dealing with invalid byte seque=
nces is just outsourced to software
> further below in the tool chain=20
>(at some point a replacement character =EF=BF=BD should be displayed t=
o the user instead of the invalid raw bytes).
>=20
> I am not entirely sure where this discussion should lead to.=20
Yes, until someone writes a patch to improve either the documentation o=
r the code,
nothing will be changed.
> However, I think that if the behavior of the software will not be cha=
nged,=20
>then the documentation for the --encoding option should be more precis=
e and=20
>clarify what actually happens behind the scenes. What do you think?
Patches are more than welcome.
>=20
>=20
> Cheers,
>=20
>=20
> Jan-Philip Gehrcke
