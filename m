From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: RFE: support change-id generation natively
Date: Thu, 24 Oct 2013 20:31:26 +0700
Message-ID: <CACsJy8DA7_vGpeJw8QurmJsy9k1am4CWN2pT_RTpD+vcpQc+8g@mail.gmail.com>
References: <2127507934.9293293.1382367063640.JavaMail.root@openwide.fr>
 <201310212029.01589.thomas@koch.ro> <1382380858.25852.36711509.53CF173C@webmail.messagingengine.com>
 <201310211249.49568.mfick@codeaurora.org> <xmqqy55lrsoo.fsf@gitster.dls.corp.google.com>
 <CACsJy8A7r-gsbru0eLxtJbFk2vgqvBH9akHn6e53k=UJbZ1K7Q@mail.gmail.com>
 <xmqqzjq0q8nl.fsf@gitster.dls.corp.google.com> <CACsJy8CuEvdTu+P-P-kYC0dKQKnjh5sRoevd_hsbqF0796i0xw@mail.gmail.com>
 <8D1AF6D7-F7AA-4E64-B6B3-3C8C931312C3@codeaurora.org> <CACsJy8BoqWMqGPM8JDny6mxkxZzhWrQ6RYZiNK=vzdwXL4a=vQ@mail.gmail.com>
 <5268B7D6.5050106@viscovery.net> <1382616665.23343.37953397.70FB76CB@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Nasser Grainawi <nasser@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>,
	Martin Fick <mfick@codeaurora.org>,
	Thomas Koch <thomas@koch.ro>,
	Jeremy Rosen <jeremy.rosen@openwide.fr>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: james.moger@gitblit.com
X-From: git-owner@vger.kernel.org Thu Oct 24 15:32:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZL17-0006c9-P1
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 15:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755115Ab3JXNb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 09:31:57 -0400
Received: from mail-qc0-f182.google.com ([209.85.216.182]:57612 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755105Ab3JXNb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 09:31:57 -0400
Received: by mail-qc0-f182.google.com with SMTP id n7so1323212qcx.41
        for <git@vger.kernel.org>; Thu, 24 Oct 2013 06:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=N0psy7oIW6Wi9d7PNQwlxBE0hesHyZvChTkknXrBx4M=;
        b=FXxrV0wCtGQ5UhZX0/qMZMd/JDqX76sq7XjMZ7r0i1vTrrAmm6ksKTJtiUZjL9dhnD
         gJiR5Cx7Pz6YBYbF4L3oBWVhwcCC4fcpanunijU+C4tJOJ59nqYX/Zr3+AsoEPhrIL8L
         yzHCaRSMhAbC68Zmt/MSaHxa/A26ftkTc4w3ag1o2YSx3F1SeWtea+w4qYKx3FS8g8EW
         gWiJQhFUB1gRzeeqB4/F+tFc6DeJYyuui4Ttdb0hD8pgEgjNkGaGJCrvETXg3LseGnup
         h3hoMKZeJ2QMxNISiiKrOXKEHfrEm5QU9F91DN+90skxs8K5O8ZGz8iPr4msihyyudbl
         Sc6w==
X-Received: by 10.224.16.8 with SMTP id m8mr4102642qaa.28.1382621516294; Thu,
 24 Oct 2013 06:31:56 -0700 (PDT)
Received: by 10.96.27.202 with HTTP; Thu, 24 Oct 2013 06:31:26 -0700 (PDT)
In-Reply-To: <1382616665.23343.37953397.70FB76CB@webmail.messagingengine.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236585>

On Thu, Oct 24, 2013 at 7:11 PM,  <james.moger@gitblit.com> wrote:
>> That said, I don't think that --change-id option that the user must not
>> forget to use is any better than a hook that the user must not forget to
>> install.
>
> Having a --change-id option, to my mind, simplifies use of the patch
> workflow as it does not require downloading, copying and setting
> executable a hook script per-repository or globally.

This could be solved by shipping the hook with git. So all you need to
do is "git init --template=gerrit". --template requires full path, but
I think we can change it to accept a name and look for $datadir/$name.
A more interesting case is removing the hook. I admit I haven't found
any neat way to do it without messing in $GIT_DIR/hooks manually.

> I agree that
> forgetting to add it on the command-line is a potential problem.  This
> could be improved by honoring the "gerrit.createchangeid" value (or
> whatever setting name is appropriate).  Of course that still requires
> configuring the repo after clone, but it's clean and straight-forward
> since it is all plain "git config".
>
> -J



-- 
Duy
