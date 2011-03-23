From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: git cherry improvements suggestions
Date: Wed, 23 Mar 2011 14:23:13 +0100
Message-ID: <AANLkTinXh_Y9ft5Pd5SxOEXvKNm3HLmsiut8WrvFZrdQ@mail.gmail.com>
References: <AANLkTimk0bkOGVy2W+XddHRuf-1xw+d0RwzPhnk40vi8@mail.gmail.com>
	<4D89CF8E.4070100@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 23 14:23:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2O1x-0008PO-Q5
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 14:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932835Ab1CWNXP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Mar 2011 09:23:15 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:64614 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932600Ab1CWNXO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 09:23:14 -0400
Received: by qwk3 with SMTP id 3so5900802qwk.19
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 06:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=g+mmRFaIa/FrvaNDP0vA82HAkjUqlJL9UbZ67wQebJc=;
        b=bRYOCyrI0FAKT9nvfrhyuoBR2SPosztOv+ytgIBc46CEId7GQYNQx0TWrIdny71V6y
         3weEMzrxOE0hbNC3jKn/rVXWSBv/9/6rJ03oOm3+YEM+bG/fU2eYnc58HZPJGDLrxyg5
         caeQvjvAxDl9QVJ8sCARkrz58HalAx6N2mSVM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=x+T69BG6TiiZwkKXEiE0s40nDY3O8DpIP6V0jX6rYaWRTjp5dpEDY4tnIAZl7JX7VE
         3fYD/QeED+VmPmSMA/AUXZz33b+LbYMJh56huNLZD3L0Arm5IrzcGi7fpbIbarbMThNy
         KUk7oed/uU4h1bc7j3UHovNvz9lKZPaK3yc+c=
Received: by 10.52.95.135 with SMTP id dk7mr7224137vdb.93.1300886593478; Wed,
 23 Mar 2011 06:23:13 -0700 (PDT)
Received: by 10.220.210.16 with HTTP; Wed, 23 Mar 2011 06:23:13 -0700 (PDT)
In-Reply-To: <4D89CF8E.4070100@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169827>

On Wed, Mar 23, 2011 at 11:46 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Piotr Krukowiecki venit, vidit, dixit 23.03.2011 09:11:
>> Hi,
>>
>> Short version:
>>
>> 1. The <limit> is misleading IMO
>
> In what way? Is the documentation wrong?

No, but for me <limit> looks like numeric limit. There is no explicit n=
ote in
man page that it's a commit.


>> 2. Please extend the output to show "full diff"
>> 3. Please add numerical/time <limit>
>> 4. Would it be possible to use "=3D" for "equivalent change"?
>>
>> Please tell me your opinions.
>
> You will be a happy user of "git log --cherry A...B" instead of "git
> cherry A B". It gives you all the log option (e.g. p for diff) that y=
ou
> like and uses "=3D" rather than "-". It's currently in next and will =
be in
> the next release.

I've tried it and indeed I'm happy! :)
The "git log --cherry-mark --left-right A...B" is what I needed!

Just some stats:

   git log --cherry-mark --left-right --oneline --date-order branch...t=
runk

lists 1004 commits, takes about 20s and memory peaks to about 670MB
twice during the run (I'm on linux with AMD Phenom II X4 945)

With limit it prints X last commits (the limiting seems to take place a=
fter all
work, on the output list only).

branch..trunk is 551 commits, the other way is 453 commits.
710 commits are found to be "=3D", 98 "<", 196 ">".

Note, I'm not saying it's too slow, or that it's working incorrectly, I=
'm just
giving real-life stats if anyone was interested.
I suspect such checks won't be done frequently.

So thanks for the great improvement!


>> 1. man page says: git cherry [-v] [<upstream> [<head> [<limit>]]]
>>
>> =A0 =A0$ git cherry -v master 9_1 20
>> =A0 =A0fatal: Unknown commit 20
>>
>> After reading man page I though the limit is a numeric limit, like "=
check
>> last 20 commits".
>
> It clearly is the name of a commit in that picture.

I have assumed the limit is numerical and means number of commits.
Coming from that assumption it looked like cherry used the limit number
as a commit by mistake.



>> 2. The cherry currently shows only changes against one branch:
>>
>> =A0 =A0Every commit that doesn=92t exist in the <upstream> branch ha=
s its id (sha1)
>> =A0 =A0reported[...] The ones that have equivalent change already in=
 the <upstream>
>> =A0 =A0branch are prefixed with a minus (-) sign, and those that onl=
y exist in the
>> =A0 =A0<head> branch are prefixed with a plus (+) =A0symbol
>>
>> So it will not show commits that exist only in <upstream> but not in=
 <head>.
>>
>> In my case changes are transplanted both ways (in general), so I hav=
e to check
>> both branches.
>
> You'll be a happy user of "git log --cherry-mark --left-right A...B" =
:)

Thanks again :)


>> 3. I think a numerical limit (or even: time limit etc) of checked co=
mmits would
>> be useful, especially in "full diff" mode. Without it would be not
>
> log has a limit argument (-<number>), though I'm not sure it is exact=
ly
> what you want.

I'd be happy if the limiting was done before all the work, so the perfo=
rmance
could be improved by that.

=46or example, it could take <number> last commits from each branch and=
 check
only them.

This would help if you wanted to check only last week commits.


>> 4. The output format uses "-" to show commits that exist in both bra=
nches.
>> I find this unnatural. There probably is a reason for this? But mayb=
e it would
>> be possible to change the symbols? For example:
>>
>> =A0 =A0- commit in upstream only
>> =A0 =A0+ commit in head only
>> =A0 =A0=3D equivalent commit
>>
>> Or "<", ">", " " or any other graphic symbol.
>
> git log --cherry-mark --left-right will use <,=3D,>
> git log --cherry-mark or --cherry will use *,=3D
>
> (And yes, you can use it with --graph!)



I've done some quick tests to see how --cherry works, maybe someone
will find them useful:

# setup
$ echo a > a && git add a && git commit -a -m a
$ echo b > b && git add b && git commit -a -m b
$ echo a1 > a && git add a1 && git commit -a -m a1
$ echo a1 > a && git add a && git commit -a -m a1
$ git checkout -b topic HEAD^
$ echo b1 > b && git add b && git commit -a -m b1
$ echo c > c && git add c && git commit -a -m c
$ git checkout master
$ echo d > d && git add d && git commit -a -m d

# cherry pick a1 into topic and b1 into master

$ git log --oneline --graph topic master
* b1f200c a1
* 6b95eb4 c
* ab34325 b1
| * 15ff34f b1
| * d78c15d d
| * ace8ef2 a1
|/
* 9d88558 b
* bd17dd4 a

$ git log --oneline --cherry topic...master
=3D 15ff34f b1
+ d78c15d d
=3D ace8ef2 a1

$ git log --oneline --cherry master...topic
=3D b1f200c a1
+ 6b95eb4 c
=3D ab34325 b1

$ git log --oneline --cherry -2 topic...master
=3D 15ff34f b1
+ d78c15d d

$ git log --oneline --cherry -2 master...topic
=3D b1f200c a1
+ 6b95eb4 c


$ git cherry topic master
- ace8ef21d85b060b98d3f7d8a3b3753ee9b98317
+ d78c15df0ee457f77dab7b0b247735dfec246b65
- 15ff34f8a342b6e8999d0e5d528e0b8875fb8042

$ git cherry master topic
- ab343256684621d5bc68084f1d77f1b8312b6a3b
+ 6b95eb4c01647de623f478219eb932b07b97edc6
- b1f200c49c562517eafd77872bf5394960eee53f


--=20
Piotr Krukowiecki
