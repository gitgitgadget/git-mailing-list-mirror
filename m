From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Locking files / git
Date: Thu, 19 Sep 2013 02:42:47 +0530
Message-ID: <523A174F.4030905@gmail.com>
References: <CACPGbcsB-ieZnS5maQgtnRTifFON9fEFpCGGdHtQ2ZjySdxDYA@mail.gmail.com> <20130917213619.GM28675@paksenarrion.iveqy.com> <CACPGbcv+w=p+Zk_+djL8ONEWN4LfDNbeVbxcpk-TJX=B3To=gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Nicolas Adenis-Lamarre <nicolas.adenis.lamarre@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 18 23:12:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMP3R-0003aF-1t
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 23:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867Ab3IRVMx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Sep 2013 17:12:53 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:37578 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606Ab3IRVMw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 17:12:52 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp2so7553612pbb.14
        for <git@vger.kernel.org>; Wed, 18 Sep 2013 14:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=xRtoxxKYfqJaRqA0QL6EWFCcWf1OR6R7XoFG+GCbeR8=;
        b=KgB/TJWr/sHjFYiE8FNhvZ7ftW/8emju5wzBMvfhNVBen9bppUGxvsHxBxKuwO7wBT
         t3nKGVC4AWESkVhfa+a/brtgC5SMF07JpHwY+0sDElye7dwc8+Rso79RpaggSgzWvqpM
         R2q+E2kHX47qxWhZGUV7GjNYQKy8TAEVd042SmD2h1xiZoQTSlxm3K7uNVoEr5VnuRK6
         yaT086PD7NdM0XZAVzSuAV2LDT4/pESAo2zma5k3VD48DuVc6NpQdbBSxOK09dFpQ4sj
         1ju97fy5nNoK7sJ1gDDCGd809mEbDxfzAqp8RwRSZPWFowjHzJIuP4hYmXj3yBxPMkoF
         UnEQ==
X-Received: by 10.66.146.199 with SMTP id te7mr22476903pab.106.1379538772179;
        Wed, 18 Sep 2013 14:12:52 -0700 (PDT)
Received: from sita-lt.atc.tcs.com ([117.216.209.115])
        by mx.google.com with ESMTPSA id u7sm4679193pbf.12.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 18 Sep 2013 14:12:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130805 Thunderbird/17.0.8
In-Reply-To: <CACPGbcv+w=p+Zk_+djL8ONEWN4LfDNbeVbxcpk-TJX=B3To=gg@mail.gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234995>

On 09/18/2013 03:42 PM, Nicolas Adenis-Lamarre wrote:
> Thanks a lot for your answer.
> That's really good arguments that i was waiting for and that i have
> not get until now.
>=20
> My comprehension now :
> - it's not easy to maintain several versions of a binary file in para=
llel.
> So basically, it's not recommanded to have complex workflow for binar=
y files.
> In case the project has a low number of binary files, it can be handl=
e
> by simple communication,

Yes.  Since you mentioned gitolite in your original post, I assume you
read this caution also in the doc [1]:

    "Of course, locking by itself is not quite enough. You may still ge=
t
    into merge situations if you make changes in branches. For best
    results you should actually keep all the binary files in their own
    branch, separate from the ones containing source code."

The point is that locking and distribution don't go together at all.
The **core** of distributed VCS is the old "coding on an airplane"
story.  What if someone locks a file after I am in the air, and I manag=
e
to get in a good 4 hours of solid work?

CVCSs can also get into this situation, but to a lesser extent, I think=
=2E
At least you won't be able to commit!

[1]: http://gitolite.com/gitolite/locking.html

> In case the project has a lot of binary files, a simple workflow with
> a centralized workflow is recommanded
> - git doesn't hate locks, it's just that it's not the layer to
> implement it because git is workflow independant. Locks depend on a
> centralized server which is directly linked to the workflow.
>=20
> I'm not trying to implement a such workflow. I'm just curious, readin=
g
> a lot of things about git, and trying to understand what is sometimes
> called a limitation of git.

It's not a limitation of git.  It's a fundamental conflict between the
idea of "distributed" and what locking necessitates.

> A simple line in the documentation to say that locking should be
> handled in the upper layer (and it's done for example in gitolite)
> because it's dependant of the workflow could help some people looking
> about that point.

=46or people who don't realise how important the "D" in DVCS is, and
assume some sort of a central server will always exist, this "simple
line" won't do.  You'd have to explain all of that.

And for people who do understand it, it's not necessary :-)

> Thanks a lot for git.
>=20
> 2013/9/17 Fredrik Gustafsson <iveqy@iveqy.com>:
>> On Tue, Sep 17, 2013 at 09:45:26PM +0200, Nicolas Adenis-Lamarre wro=
te:
>>> Ooops. It seems that each time somebody says these two words togeth=
er,
>>> people hate him, and he is scorned by friends and family.
>>>
>>> For the moment, i want a first feedback, an intermediate between
>>> "locking is bad" and "ok", but i would prefer in the negativ answer
>>> something with arguments ("Take CVS as an example of what not to do=
;
>>> if in doubt, make the exact opposite decision." is one), and in the
>>> positiv answer, good remarks about problems with my implementation
>>> that could make it better.
>>
>> So working with locks and text-files is generally stupid to do with =
git
>> since you don't use git merging capabilities. Working with binary fi=
les
>> in git is stupid because git doesn't handle them very well because t=
hey
>> the deltas can't be calculated very good.
>>
>> It seems to me that if you need to do locking one of the above scena=
rios
>> is true for you and you should not use git at all.
>>
>> However, there's always the case when you've a mixed project with bo=
th
>> binary and text-files. In that case I believe Jeff gave an excellent=
 answer.
>>
>> But think twice, are you using git in a sane way? Even a small binar=
y
>> file will result in a huge git repo if it's updated often and the
>> project has a long history.
>>
>> --
>> Med v=E4nliga h=E4lsningar
>> Fredrik Gustafsson
>>
>> tel: 0733-608274
>> e-post: iveqy@iveqy.com
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
