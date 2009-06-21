From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: bug/feature request: apply textconv in "git add -p" diff output
Date: Sun, 21 Jun 2009 22:17:56 +1000
Message-ID: <fcaeb9bf0906210517s49ed029fr84d31b14b0184bb7@mail.gmail.com>
References: <fcaeb9bf0906200017x6cc63c29q5515c11c202e424e@mail.gmail.com> 
	<4A3CAEBB.9030107@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun Jun 21 14:24:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIM5s-0002nF-7n
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 14:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407AbZFUMYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 08:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753335AbZFUMYF
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 08:24:05 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:56220 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665AbZFUMYD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 08:24:03 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1554431ywb.1
        for <git@vger.kernel.org>; Sun, 21 Jun 2009 05:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=7NXXk9BgTE94x5avxuKZZA5W9W7ZS82YIc9AFUxVHuA=;
        b=O4KhW8vN/e6I999OJWgbjlJ7I/zeYI88CGto+J1vh46dW4i9woB4hfp78Ljq1z4aYD
         +7TzvXkUwfuO68oi5gecjRp+U3GCZq4D+yXBeT1ZkwxxArIxJbmo1o/+8Mc/eAwE3YYp
         W0Yk9HnIjfr1sSbnIfHh4MgTDcQZneJkZjCIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=XV4l2IjV92HCd4DtpScki7fkD4gPxU7VdEmRrToHEx4WPayQa58nH0qg3lv/Yos4t7
         nzJ/X3q5UdxH20I+Rf8IHk5ySaUG8YYHvI2OygbBwiyqy6yP3KDGmYX5mvzdioLyvv55
         0VDvrPHtCybuyE6Db3P2Tk1xai5xJLG7at6BE=
Received: by 10.100.255.7 with SMTP id c7mr6465674ani.171.1245586696105; Sun, 
	21 Jun 2009 05:18:16 -0700 (PDT)
In-Reply-To: <4A3CAEBB.9030107@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121985>

On Sat, Jun 20, 2009 at 7:41 PM, Michael J
Gruber<git@drmicha.warpmail.net> wrote:
> Nguyen Thai Ngoc Duy venit, vidit, dixit 20.06.2009 09:17:
>> Hi,
>>
>> I use git to manage bdf font files. It it quite cryptic so textconv
>> for diff output makes it much easier to keep track of changes. The
>> only problem is that "git add -p" does not seems to use textconv, so I
>> have to run in parallel "git diff" and "git add -p", then add chunks
>> accordingly. Can somebody add textconv support to "git add -p" please?
>> I'm not so good at Perl to do the job.
>
> I don't think this is possible: textconv filters are meant to produce
> easily readable output from diff, but in no way are they required to be
> injective mappings. So, textconv output cannot to be used in order to
> specify a patch uniquely.
>
> The appropriate approach is to use smudge/clean filters. They are
> mutually inverse. And, in fact, I just checked: add -p uses the cleaned
> version. So, if clean converts to "something textual" which gives you
> readable diffs and meaningful stats (and smudge converts to binary bdf)
> then that is the way to go.

Right, I did not notice because mine was line by line translation.
I'll convert it to clean filter. Thanks.
-- 
Duy
