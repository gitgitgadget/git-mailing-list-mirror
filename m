From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Bug when git rev-list options "--first-parent" and "--ancestry-path"
 are used together?
Date: Sat, 25 May 2013 21:54:30 +0200
Message-ID: <51A116F6.7080907@alum.mit.edu>
References: <519DEA48.10108@alum.mit.edu> <7vtxltfwaa.fsf@alter.siamese.dyndns.org> <519F0B2F.3090701@alum.mit.edu> <7v4nds9rhh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Kevin Bracey <kevin@bracey.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 25 21:54:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgKY2-0003rr-FK
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 21:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757914Ab3EYTye convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 May 2013 15:54:34 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:65352 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757763Ab3EYTyd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 May 2013 15:54:33 -0400
X-AuditID: 12074413-b7f226d000000902-18-51a116f81478
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 50.D0.02306.8F611A15; Sat, 25 May 2013 15:54:32 -0400 (EDT)
Received: from [192.168.69.140] (p4FDD49F3.dip0.t-ipconnect.de [79.221.73.243])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4PJsUFD025610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 May 2013 15:54:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <7v4nds9rhh.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsUixO6iqPtDbGGgQfseA4uuK91MFg29V5gt
	Tq/Yy+rA7PH/ahujx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGcc2XeFseCkUcWHu39YGhj/
	KXUxcnJICJhIrPjygR3CFpO4cG89WxcjF4eQwGVGiQevLzJDOOeZJKY1P2EFqeIV0JY4sOQY
	I4jNIqAqsXvSHjCbTUBXYlFPMxOILSoQJvF+2VSoekGJkzOfsIDYIgJqEhPbDoHZzAK+EvOW
	9jKD2MICaRK3v51jhFg2l1FiSvsnsKGcAmYSp1/MAxrEAdSgLrF+nhBEr7xE89bZzBMYBWYh
	WTELoWoWkqoFjMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3TN9XIzS/RSU0o3MUJCV3gH466T
	cocYBTgYlXh4BcrnBwqxJpYVV+YeYpTkYFIS5dUQXRgoxJeUn1KZkVicEV9UmpNafIhRgoNZ
	SYTXih8ox5uSWFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4M0CxqiQYFFq
	empFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPChS44uBsQqS4gHaywbSzltckJgLFIVoPcVo
	zLH5/OR3jBwzfgBJIZa8/LxUKXFeW5BSAZDSjNI8uEWwpPWKURzob2FeWZAqHmDCg5v3CmgV
	E9Cqm7nzQVaVJCKkpBoYQ5Vm3F51Kr2hbvLBkEudFk+ir71MV3p3ujj6/tdl6i534/YffrtM
	S2/yo3nP03/PDtn1Pvwa+/vY1jkRJzf37eEQVN/+ZrXdT5Hd9rqLRZofi6y2zTed 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225530>

On 05/24/2013 08:12 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>=20
>> Now assume a slightly more complicated situation, in which master ha=
s
>> been merged to feature branch at some point:
>>
>> o - 0 - 1 - 2 - 3 - 4    =E2=86=90 master
>>      \       \
>>       A - B - C - D      =E2=86=90 branch
>>            \     /
>>             X - Y
>>
>> Now when we do an incremental merge branch into master, how do we
>> generate the list of commits to put one each axis of the table?  The
>> merge base is "2", so I think the best answer is
>>
>> 1- 2 - 3  - 4   =E2=86=90 master
>>    |   |    |
>>    C - C3 - C4
>>    |   |    |
>>    D - D3 - D4  =E2=86=90 final merge
>>    =E2=86=91
>>  branch
>=20
> I am not sure if that is the best answer, though.
>=20
> After managing to create Cn, if a change between C and D (which come
> from X and Y) is too complex, wouldn't you want to break down the
> task to come up with Dn recursively into a smaller subtask of
> merging X first and then Y on top and finally D?

OK, so let's assume that C3 is done and D3 is giving us problems:

o - 0 - 1 - 2 - 3 - 4    =E2=86=90 master
     \       \   \
      \       \   C3- ?
       \       \ /   /
        A - B - C - D      =E2=86=90 branch
             \     /
              X - Y

Your proposal is not to merge D directly but rather to merge X then Y.

o - 0 - 1 - 2 - 3 - 4    =E2=86=90 master
     \       \   \
      \       \   C3 --- X3 - Y3 - D3
       \       \ /      /    /    /
        A - B - C - D- / -- / ---'   =E2=86=90 the lines here...
             \     /  /    /
              X - Y- / ---'          =E2=86=90 ...and here don't inters=
ect
               \    /
                `--'

The problem is that the merges that would be required are not able to
take advantage of the conflict resolution that was done in D:

The merge base for X3 would be B.  This is a little bit wrong because X=
3
includes C among its ancestors, so creating X3 requires some of the
conflicts between X and C (which were resolved once in D) to be resolve=
d
again.

The merge base for Y3 would be X.  Note that Y3 already includes C and =
Y
among its ancestors.  Therefore, resolving Y3 involves resolving the
same conflicts between Y and C that were already resolved in D.  But
since merge Y3 doesn't know about D, the user would be forced to resolv=
e
those conflicts again (albeit maybe helped by something like rerere).

And merge D3 would have two merge bases, C and Y.  This is related to
the fact that there are now two independent known resolutions for
merging C and Y, namely D and Y3.

Given that Y3 in the above scenario needs to include include C (via C3)
and also Y, it seems to me that this merge is superfluous.  It should
have exactly the same content as D3, assuming that the conflicts are
resolved the same way.  Therefore one could skip Y3 and proceed directl=
y
to D3:

o - 0 - 1 - 2 - 3 - 4    =E2=86=90 master
     \       \   \
      \       \   C3 --- X3 - D3
       \       \ /      /    /
        A - B - C - D- / ---'        =E2=86=90 the lines here...
             \     /  /
              X - Y  /               =E2=86=90 ...and here don't inters=
ect
               \    /
                `--'

This merge could take advantage of the conflict resolution that was don=
e
in D.  It would have an unambiguous merge base, C.

But I still think that this approach is not as clean as an incremental
merge of two linear branches, because X3 requires some of the same
conflicts to be resolved as were already resolved in D.

Incidentally, if merge D had been done incrementally and the full
incremental merge resolution had been kept, then we would have the
missing merge CX that would allow us to compute D3 incrementally:

o - 0 - 1 - 2 - 3 - 4    =E2=86=90 master
    |       |   |
    A - B - C - C3
        |   |   |
        X - CX- C3X
        |   |   |
        Y - D - D3

I think that all of the required merges have sane merge-bases and take
advantage of all of the merges that have been done previously.  This is
another case where an incremental merges contains information that can
be useful for the future.

>> The simplest way I can think of to generate the list C,D is
>>
>>     git rev-list --first-parent --ancestry-path 2..D
>>
>> We need --ancestry-path to avoid getting commits A and B.  It's stil=
l
>> not clear that this is always the best approach but at least it seem=
s
>> safe.
>=20
> Hmm, while I agree that A and B will be omitted by using ancestry
> path on the example topology, I need to be convinced that it is
> impossible to end up with disjoint segments of a history in any
> ancestry graph by combining -f-p and -a-p that way to feel "safe".

If by "disjoint" you mean that the history contains gaps, that is
exactly what happens in the case I described in my last email:

o - 0 - 1 - 2 - 3 - 4    =E2=86=90 master
     \       \
      A - B - C --.
           \       \
            X - Y - D    =E2=86=90 branch

The result of "git rev-list --first-parent --ancestry-path 2..D" would
be only D and commit C would disappear into the "gap".

I am willing to accept that for my application, because the incremental
merge algorithm can work despite gaps in the history but it cannot work
if the ancestry property is not met.

>> This is my reason for wanting --first-parent and --ancestry-path to =
work
>> together.
>>
>> For now I'm just running rev-list twice and computing the intersecti=
on
>> by hand, but it was surprising that git could not do this for me.
>=20
> Wouldn't you be able to read everything you need out of a single
>=20
> 	git rev-list --left-right --parents master...branch
>=20
> output?
>=20
> By the way, there is a fairly major fixes to the revision traversal
> machinery that has been parked on pu, which leads to 141efdba57b1
> (revision.c: make default history consider bottom commits,
> 2013-05-16).  The topic revises the semantics of ancestry-path to
> bring more sanity to it.
>=20
> I haven't had time to see how it changes the situation for the use
> case you described in the message I am responding to, but I think it
> is worth checking to see how well it meshes with your expectation,
> and if it doesn't involve Kevin in the design discussion.

I'll look into all of these suggestions; thanks.  I'm also CCing Kevin
on this email.

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
