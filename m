From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Re: Why the default action for pull is merge, but not rebase?
Date: Wed, 27 Oct 2010 13:58:45 -0400
Message-ID: <AANLkTinDaYr8fsZiit4VYH-vptO7LtwRggkFGLKMnAhY@mail.gmail.com>
References: <20101027173644.GB15657@burratino>
	<0016e645b8c87a160804939cdc5e@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>,
	Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 19:59:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBAH6-0002F8-9Q
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 19:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031Ab0J0R6t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 13:58:49 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49338 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978Ab0J0R6r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Oct 2010 13:58:47 -0400
Received: by ywk9 with SMTP id 9so632026ywk.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 10:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MU1RALUvlrjy2AHDWSQQkybMBfmRMLsVJmEJR46BCtw=;
        b=ChgccO7wReAOFw/TLK9FVBboZ+8Mf9Zet1ncgMw+ChhjGUTJgBynq7g3NZymemcq8x
         qxbqe0PngjK0O7OghTnDGkc0PNxAJVqjjKxA5bqrf0Yo4nDV63v2NCzLGjUk4AuFbtRB
         KtcrDUXN0doAfJcRgqLTytWK6UFvC1SEh2wk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=p46FoxKUDnomtDpa8cteYB1+UTWr4PbHgmJA8WIywhsC44HajnJfwsf5kTbmfab6AF
         dMFBrbZ0X82+alxxyHUFcE7EbRnFvgghH3N7qpWlaVIIV2pYUPM81HEJOlVh34DhfXfX
         jPfgSXowbme+YwKDtMULxAyACsqrIWeIL02Oo=
Received: by 10.204.142.92 with SMTP id p28mr7830624bku.2.1288202325668; Wed,
 27 Oct 2010 10:58:45 -0700 (PDT)
Received: by 10.204.46.207 with HTTP; Wed, 27 Oct 2010 10:58:45 -0700 (PDT)
In-Reply-To: <0016e645b8c87a160804939cdc5e@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160108>

On Wed, Oct 27, 2010 at 1:50 PM,  <Euguess@gmail.com> wrote:
> On Oct 27, 2010 1:36pm, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Eugene Sajine wrote:
>>
>>
>>
>> > Thanks for prompt answer. But let me clarify:
>>
>> >
>>
>> > When you do pull git performs:
>>
>> >
>>
>> > fetch of the remote branch to the FETCH_HEAD
>>
>> > and then merge of FETCH_HEAD into the local branch
>>
>> >
>>
>> > What I'm saying is that your local branch should be rebased on top=
 of
>>
>> > FETCH_HEAD instead
>>
>> >
>>
>> > In this case there is no such thing as "often rebased public branc=
h".
>>
>>
>>
>> Ah, but there is.
>>
>>
>>
>> Imagine you are Junio and just received a pull request from Pat.
>>
>> Then you might try:
>>
>>
>>
>> =C2=A0$ git pull pat for-junio
>>
>>
>>
>> which will do all the fetching and merging magic that "git pull"
>>
>> is known for. =C2=A0Now if pat's for-junio branch is based on the ti=
p
>>
>> of your current branch, this will be a fast-forward and it doesn't
>>
>> matter whether you merge or rebase. =C2=A0But what if there are some
>>
>> intervening commits?
>>
>>
>>
>> =C2=A0$ git pull eric for-junio
>>
>> =C2=A0$ git pull pat for-junio
>>
>>
>>
>> If this pull were the rebasing kind, the result would be for Eric's
>>
>> commits to be rewritten based on Pat's.
>>
>
> Oh, I see. In this case you're right.
> My scenario is probably making more sense for the "centralized approa=
ch",
> where the exchange goes via some blessed bare repo on the server.
> So, I just have to run git pull --rebase to get my scenario working, =
right?
>
>
> Thanks!
> Eugene

Actually it seems that it will not work as i would expect...
git pull --rebase is going to rebase the upstream on top of my local
branch, right? Is this really intended behavior? Shouldn't it rebase
my local on top of the upstream instead?

Thanks,
Eugene
