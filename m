From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 7/7] gitweb: group remote heads
Date: Wed, 22 Sep 2010 10:34:10 +0200
Message-ID: <201009221034.10958.jnareb@gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com> <201009201059.07742.jnareb@gmail.com> <AANLkTi=20gzw8DOuT=NWRqbt86AyJDEPxoo-V9A3Rvim@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 22 10:34:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyKmb-00036H-TF
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 10:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293Ab0IVIeX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Sep 2010 04:34:23 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40137 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017Ab0IVIeW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 04:34:22 -0400
Received: by fxm3 with SMTP id 3so141463fxm.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 01:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:content-type:content-transfer-encoding
         :message-id;
        bh=2Z/73ivg7meNt4mvNZfPckClBiU8ukzAmHNynJ0RIL0=;
        b=PW4k4bEikryCqAReMhrkjBPGJglF8jDr517LPW6bKQvyKDdzzM3j0iXaYJO+ZMp21p
         9wHexzA/WDrZkI3FF91t0ScAuK11vVR5qutl9VA++JZ4cFTYuEOLVNaZFkVrBTBWvQJ+
         Sn9lBkc637nBa1mtdxo8flwhmQxMx6qgiTfFY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        b=R9mJ+tUl9fbao+DzaYJ3cRcNaoyA/ENa7+vl8AKCDS4zHQKHdOPFH2fZm/cP6+mL/f
         8hn4IRGWXYrlJQZSgr2PJ+Lxq6pYl+ReJwCcXumyUc9DWcrAz0pZ65QJsvCpGkkb0LrI
         xTOtF10O388h7/cTI+2eRBjbZpr6M+jnhnjyA=
Received: by 10.223.123.77 with SMTP id o13mr4884172far.63.1285144460718;
        Wed, 22 Sep 2010 01:34:20 -0700 (PDT)
Received: from [192.168.1.13] (abvk112.neoplus.adsl.tpnet.pl [83.8.208.112])
        by mx.google.com with ESMTPS id r8sm4090873faq.10.2010.09.22.01.34.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Sep 2010 01:34:19 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTi=20gzw8DOuT=NWRqbt86AyJDEPxoo-V9A3Rvim@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156792>

On Mon, Sep 20, 2010, Giuseppe Bilotta wrote:
> On Mon, Sep 20, 2010 at 10:59 AM, Jakub Narebski <jnareb@gmail.com> w=
rote:
>> Giuseppe Bilotta wrote:
>>> On Mon, Sep 20, 2010 at 1:02 AM, Jakub Narebski <jnareb@gmail.com> =
wrote:

>>>> The solution (1) i.e. limiting number of remote heads per remote, =
with
>>>> or without limiting number of remotes behaves, as you wrote, most
>>>> similarly to other components of 'summary' view. =A0On the other h=
and
>>>> with large number of remotes, and large number of remote heads in =
those
>>>> remotes it might be too large for a *summary* view.
>>>
>>> So you maintain that limiting the amount of data in summary view
>>> should be primary wrt to limiting the amount of time?
>>
>> Well, what really affect gitweb performance is calling git commands,=
 both
>> because of fork overhead, and because it means disk access (and gitw=
eb
>> performance from what I have heard is affected mainly by IO, and not=
 CPU).
>> With grouping (displaying remotes) the difference between displaying
>> remote-tracking branches (or information from them) and not displayi=
ng
>> them is an argument to git-for-each-ref. =A0So I don't think it woul=
d
>> affect performance much.
>=20
> Getting the list of remote branches is, I would say, the most
> IO-intensive operation. I'm not sure how much I/O it would do though,
> even with a large number of remotes and heads. So maybe always gather
> all the information is the way to go.

Well, that depends on the number of remote-tracking branches, and wheth=
er
those refs are packed (see git-pack-refs).  But I agree that getting li=
st
of all remote branches might be I/O hit... though I am not sure if it
would be large enough to visibly affect gitweb performance.
=20
By the way, besides the solution described below (list only remotes if
there are many of them), we could make 'remote_heads' be not simply
boolean, but to be multiple-choice feature, configuring how 'remotes'
view and remotes section in 'summary' page looks like.  But that might
be overengineering.

>>> If time spent processing is not an issue, we can retrieve the numbe=
r
>>> of heads for each remote and display that, for example. Or even pla=
y
>>> with some more dynamic stuff like making each group collapsible,
>>> starting with it collapsed and then display the content when the us=
er
>>> hovers it with the mouse, for example.
>>
>> The dynamic stuff is IMHO a good idea... provided we can either do i=
t
>> without JavaScript, or we can ensure that browser supports JavaScrip=
t
>> (see current hack used for turning 'blame' into 'blame_incremental'
>> view in gitweb).
>=20
> What I had in mind was something that is very easy to implement with
> CSS only.=20

Do I understand correctly that you would utilize ':hover' pseudoclass
and 'display: none;' style?  How ergonomic would this solution be?
=20
>> Yet another solution would be to display only abbreviated list of re=
motes
>> if its more of them than some threshold, and list remotes with abbre=
viated
>> list of remote-tracking branches if there are only a few remotes.
>=20
> So something like this:
>=20
> (1) if there are more than N remotes, only show N remote _names_ (no =
heads)
> (2) if there are no more than N remotes, show all remote names, each
> with no more than M heads
>=20
> (with N and M to be decided, e.g. the usual 16)

Right.

>>> Yes, this is something I have to take into consideration. Skip
>>> displaying them is probably the best idea (unless we have other way=
s
>>> to gather information about them).
>>
>> Right.
>=20
> For this, it would be nice to have `git remote show`, but even if I
> sent a patch to this effect gitweb should probably be left able to
> cope with older git versions not supporting it ...
>=20
>> P.S. It is not necessary for this series, but I think we should thin=
k
>> about "single remote" view... also because your code currently links
>> to such views, which do not exist yet (remotes/<remote> in path_info=
:
>> how it would be represented in CGI query format?).
>=20
> Maybe pass the remote name as head parameter?

In the meantime, while we don't have 'remote' view for a single remote
(something like "git remote show"), it would be good if the header for
individual remotes didn't lead to "'remotes/<remote>' action".

--=20
Jakub Narebski
Poland
