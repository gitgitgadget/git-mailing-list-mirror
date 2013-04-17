From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Wed, 17 Apr 2013 22:06:58 +1000
Message-ID: <CACsJy8Bw6x=WiQUi0C4ZtEQiA9ia8ZFgz5uH61K6kf-JPy1xyg@mail.gmail.com>
References: <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com>
 <20130407170201.GH2222@serenity.lan> <CALkWK0nSxfEzP7KHZxGjmBYD7pX5aa3CbMt1qAGrz4tonrtHhA@mail.gmail.com>
 <20130407175210.GI2222@serenity.lan> <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan> <5161BC33.8060707@web.de>
 <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com>
 <5161D3C5.9060804@web.de> <CALkWK0k_vmXZr-x8=ZctouWbuVgv-1sptC0WX2aJ+yYD-T8cxA@mail.gmail.com>
 <20130407212342.GA19857@elie.Belkin> <CACsJy8BoWfng7p=kHbiF9s6XYH1mPMtAGW6BRz54uYM5454O0w@mail.gmail.com>
 <CALkWK0mcnA8Qss3uxRXhfHst65RLkv43wje9xdFxmFKi7MtZvA@mail.gmail.com>
 <CACsJy8Bz+yNefiiwEivaaUgRymHTmUUKEFs8_uuonhmRfT3UGg@mail.gmail.com> <CALkWK0m9QmZaSDruY=+2F-Kkw+fd6E1TYCTBpVQHRJrzq2VjCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 14:08:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USR9d-0007rd-Tr
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 14:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966286Ab3DQMHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 08:07:52 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:34110 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966252Ab3DQMH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 08:07:29 -0400
Received: by mail-oa0-f45.google.com with SMTP id o17so1351905oag.4
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 05:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Umsx+B2n6Mf+NCrN/FeU2oW2Cexx6SzggX+ih1r2+pI=;
        b=iSklyeiv+Xe3zqt7BBTXYGoUk/evX8f/2P2jGwF6lKPTZFgjw5fsjejq97+3dQ10ut
         f2j2JTfMflDz9gGc9/kwImaSt3jKyBpjDcH9sGjG20vFVwxxiPEP6Eih7UvZW0X0WxiE
         EwRAO8DYJmLE9BNJ/5c9vO9rUaviitrq+gvXVCi6I6zN5HhKqHxWX+6j4sbK8x3PRP2p
         fb+NmbJFr2rgOjoT63Ksb8LddcKHm3adp0IJKxylPZKwgZ68ImKWz83vvkOJ59eh32iu
         QIEzmUAyd0hjiSoQC3ub/tRE+PiRo897yAtEu+GhMbhUAp/fYYg1O26/kYxAaKKPTFPt
         rYWw==
X-Received: by 10.182.103.225 with SMTP id fz1mr2344310obb.53.1366200448703;
 Wed, 17 Apr 2013 05:07:28 -0700 (PDT)
Received: by 10.76.122.163 with HTTP; Wed, 17 Apr 2013 05:06:58 -0700 (PDT)
In-Reply-To: <CALkWK0m9QmZaSDruY=+2F-Kkw+fd6E1TYCTBpVQHRJrzq2VjCQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221539>

On Wed, Apr 17, 2013 at 9:56 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
>> why not reuse tag object with some nea header lines?
>
> Or a unified blob, which is currently what we have.  The point is to
> have structured parseable information that the object-parsing code of
> git code and easily slurp and give to the rest of git-core.

I think you misunderstood. I meant instead of introducing new object
type OBJ_LINK, you can reuse tag object and add new header lines for
your purposes.

> Please clear your reading backlog to avoid bringing up the same points
> over and over again.

Yep. I'll shut up until it's cleared.
--
Duy
