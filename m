From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 7/7] gitweb: group remote heads
Date: Wed, 22 Sep 2010 11:34:33 +0200
Message-ID: <AANLkTimn3EfW3ZAZWeAoq7Jv5c4Hu5LM0K7UeE41Si-Z@mail.gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com>
 <201009201059.07742.jnareb@gmail.com> <AANLkTi=20gzw8DOuT=NWRqbt86AyJDEPxoo-V9A3Rvim@mail.gmail.com>
 <201009221034.10958.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 22 11:35:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyLjC-0002Yi-7V
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 11:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932Ab0IVJey convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Sep 2010 05:34:54 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57977 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967Ab0IVJex convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Sep 2010 05:34:53 -0400
Received: by iwn5 with SMTP id 5so391358iwn.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 02:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=TVYiaA4lmwrgjPr2bL6nrrAIgKbK7gNDbDvPc0aItW8=;
        b=IYlvJUQYQ6M/hg+/zOIyjpUffONsKFi8fvph8QIH5a98X7y+ZTcmk/7yP6Nklu7Ux1
         W3Tv3eill7f64YMLwGgvMxLA4gVY1ZWDGikOOxr8h3Ko+yLU/tNGt+ayQnERJixnbY8K
         VYRRW1LksWJg+6y9NgHzhaxi3sk+ZAwNGSAOw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=gPFZRogxdYt7ijtBlAUOGV+aeSTQikVsOjR916AODrZuPRqPlXNYGzhqkD85mL7gSC
         7ZDHiSrQGTao5/QUVRYyJ5Rt72ce2XBPFV6HFXA9OLdEUnEfCgNWDxM6iZnF/DfYrJmQ
         0AGtmM1Apcp+KYPhXTEj2Z5nF9uz+SZ8HMf3g=
Received: by 10.231.160.205 with SMTP id o13mr13761550ibx.15.1285148093211;
 Wed, 22 Sep 2010 02:34:53 -0700 (PDT)
Received: by 10.231.150.202 with HTTP; Wed, 22 Sep 2010 02:34:33 -0700 (PDT)
In-Reply-To: <201009221034.10958.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156793>

On Wed, Sep 22, 2010 at 10:34 AM, Jakub Narebski <jnareb@gmail.com> wro=
te:
> On Mon, Sep 20, 2010, Giuseppe Bilotta wrote:
>> On Mon, Sep 20, 2010 at 10:59 AM, Jakub Narebski <jnareb@gmail.com> =
wrote:
>>> Giuseppe Bilotta wrote:
>>>> On Mon, Sep 20, 2010 at 1:02 AM, Jakub Narebski <jnareb@gmail.com>=
 wrote:
>
>>>>> The solution (1) i.e. limiting number of remote heads per remote,=
 with
>>>>> or without limiting number of remotes behaves, as you wrote, most
>>>>> similarly to other components of 'summary' view. =A0On the other =
hand
>>>>> with large number of remotes, and large number of remote heads in=
 those
>>>>> remotes it might be too large for a *summary* view.
>>>>
>>>> So you maintain that limiting the amount of data in summary view
>>>> should be primary wrt to limiting the amount of time?
>>>
>>> Well, what really affect gitweb performance is calling git commands=
, both
>>> because of fork overhead, and because it means disk access (and git=
web
>>> performance from what I have heard is affected mainly by IO, and no=
t CPU).
>>> With grouping (displaying remotes) the difference between displayin=
g
>>> remote-tracking branches (or information from them) and not display=
ing
>>> them is an argument to git-for-each-ref. =A0So I don't think it wou=
ld
>>> affect performance much.
>>
>> Getting the list of remote branches is, I would say, the most
>> IO-intensive operation. I'm not sure how much I/O it would do though=
,
>> even with a large number of remotes and heads. So maybe always gathe=
r
>> all the information is the way to go.
>
> Well, that depends on the number of remote-tracking branches, and whe=
ther
> those refs are packed (see git-pack-refs). =A0But I agree that gettin=
g list
> of all remote branches might be I/O hit... though I am not sure if it
> would be large enough to visibly affect gitweb performance.
>
> By the way, besides the solution described below (list only remotes i=
f
> there are many of them), we could make 'remote_heads' be not simply
> boolean, but to be multiple-choice feature, configuring how 'remotes'
> view and remotes section in 'summary' page looks like. =A0But that mi=
ght
> be overengineering.

A config option for maximum number of remotes and maximum number of
heads per remotes (in summary) with sane defaults (16/16?) maybe?

>> What I had in mind was something that is very easy to implement with
>> CSS only.
>
> Do I understand correctly that you would utilize ':hover' pseudoclass
> and 'display: none;' style? =A0How ergonomic would this solution be?

That was my idea, yes. It _can_ get a little confusing without CSS3
transitions, due to the 'flash roll down' of the remote heads list. I
will try to cook up a preview sometime this week.

>>> P.S. It is not necessary for this series, but I think we should thi=
nk
>>> about "single remote" view... also because your code currently link=
s
>>> to such views, which do not exist yet (remotes/<remote> in path_inf=
o:
>>> how it would be represented in CGI query format?).
>>
>> Maybe pass the remote name as head parameter?
>
> In the meantime, while we don't have 'remote' view for a single remot=
e
> (something like "git remote show"), it would be good if the header fo=
r
> individual remotes didn't lead to "'remotes/<remote>' action".

True. I'll fix that for the next rehash.

--=20
Giuseppe "Oblomov" Bilotta
