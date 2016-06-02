From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Mark remote `gc --auto` error messages
Date: Thu, 2 Jun 2016 13:14:02 -0700
Message-ID: <CAPc5daXVx1=ptsKJEfEzXbjCNvwYxjAPyp_pob9CeR+Qr3tG_g@mail.gmail.com>
References: <146489432847.688.11121862368709034386@typhoon>
 <xmqqinxrtmgi.fsf@gitster.mtv.corp.google.com> <146489800609.1944.4398103814754920753@typhoon.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Lukas Fleischer <lfleischer@lfos.de>
X-From: git-owner@vger.kernel.org Thu Jun 02 22:14:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8Z0c-0004MY-Si
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 22:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbcFBUOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 16:14:22 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:33680 "EHLO
	mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbcFBUOW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 16:14:22 -0400
Received: by mail-yw0-f181.google.com with SMTP id h19so61178725ywc.0
        for <git@vger.kernel.org>; Thu, 02 Jun 2016 13:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=smc2qRfFuJIfR9Hmpw7mbdnhPJVpj/K9BIKKsQEquJ4=;
        b=RpH1hKsVhtW4HbAbqskl8B6F9kMr7Nlk5TbIoBDOR0eFOsh0wmWve85faXPUu4cXDs
         qap0FopE4gybpHs0maBTJ0YrDtuaGVorQesxYAr2LMA449vGF47WIM6Z8MAjXJYSbKEb
         4njEsrxm2ok1dLxVebdMxN9p8ZRhC/aWiLtO9S4L1RGqITBAsqyUzhQINTfrta7evmKC
         xI1fuJgYOYVsc04o7gQzkivVqqZzpIgO5wqKOQuotb8fCAnz42fc2MidT/pEnER2a3IQ
         FHbr3UXsd82SywrZWsVRBQ9xF1WWUp0rh6jkLiI1WaNVT2DjDeBLWWPwfjsteVoFqSoP
         8qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=smc2qRfFuJIfR9Hmpw7mbdnhPJVpj/K9BIKKsQEquJ4=;
        b=TjidBH94u/Cl89b68h/KNp16zc0rfUwAF5+BPSoUdallJjwqi+chrj6SOcKMuQd+tl
         qo7wb2ndfqQ6a3kGjIE82YflicKpXSFpiAjLC0aY8l0WQdnD88tJLpzolxVc8Bev8rLj
         ChtrAnwVgxDHDeZc4fGemQhRqKmLXhYClMKFfCCmqAjuD0evwEHRoAFDviEXlKIDPBav
         aSsDJSkSyPywL5cPc6PF2pnhmp7WVUdsNHTirGYp0dtPlmakxO0hHNIZsjJ4Hd0fBiD0
         bJyg9El/w2x+xAXbQPLvnHRASRRs1lkyb6ss//ogElFc0aC8EWLz5imooBwRlOSBXeiH
         IJOw==
X-Gm-Message-State: ALyK8tK/2f+3hXQ4wkJL4mhd5i7OoB48sd35KNjnCr6I4tZWzdrjSa8jErsNJKBzgE9p13O5V/V9ncgfZm2xCw==
X-Received: by 10.37.21.129 with SMTP id 123mr6873779ybv.41.1464898461394;
 Thu, 02 Jun 2016 13:14:21 -0700 (PDT)
Received: by 10.13.251.71 with HTTP; Thu, 2 Jun 2016 13:14:02 -0700 (PDT)
In-Reply-To: <146489800609.1944.4398103814754920753@typhoon.lan>
X-Google-Sender-Auth: xbufSqDHeL1IpTTKJ88C4z-Dc3w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296234>

On Thu, Jun 2, 2016 at 1:06 PM, Lukas Fleischer <lfleischer@lfos.de> wrote:
> On Thu, 02 Jun 2016 at 21:33:33, Junio C Hamano wrote:
>> Lukas Fleischer <lfleischer@lfos.de> writes:
>>
>> > When running `git push`, it might occur that error messages are
>> > transferred from the server to the client. While most messages (those
>> > explicitly sent on sideband 2) are prefixed with "remote:", it seems
>> > that error messages printed during the automatic householding performed
>> > by git-gc(1) are displayed without any additional decoration. Thus, such
>> > messages can easily be misinterpreted as git-gc failing locally, see [1]
>> > for an actual example of where that happened.
>>
>> Sounds like a sensible goal to me.
>
> What exactly are you referring to (you only quoted the introduction)?
> Do you think we should fix the git-gc issue but keep the general
> behavior of printing messages unaltered? Do you think it would be
> worthwhile to make server messages distinguishable in general?

The latter, which I think was what your implementation was attempting to do
if I read it correctly.
