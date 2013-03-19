From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Tue, 19 Mar 2013 18:33:12 +0700
Message-ID: <CACsJy8Ad7rKtMd-6BoBtbVa70F0AaJ+OUjEykNh344tPw7F7Vg@mail.gmail.com>
References: <CALkWK0nYECHZaxit9jR-tS=7fXyOP5dy6mqUz0DKmbTRU-xRNw@mail.gmail.com>
 <20130318170804.GA15924@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 19 12:34:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHunz-0005RG-GX
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 12:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144Ab3CSLdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 07:33:44 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:51465 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779Ab3CSLdn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 07:33:43 -0400
Received: by mail-ob0-f178.google.com with SMTP id wd20so297870obb.37
        for <git@vger.kernel.org>; Tue, 19 Mar 2013 04:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=QhTZkDiaR5HZNyMp5+qQYJ0ZbLXttLbKsSKjNfzwn8E=;
        b=MwdzuA3+74q4zqw7Zs13oAMGYxwgITU+cb5TCJFZFKU90b5WSUiP3QmkryFGLbyPdW
         JhLoT6exUNnHodr9ocHoerM9M670/OIytHxYF1F55BfotbsRY46MRXQkeVWCmzT5xNIQ
         PxNd2HQloZt5woVd1VsRIbaxSkhk6QDj5SYo1S5kTxGLyL6/stbEVj3hBp6oUhLThEBA
         gX6s715fHVewr/KUOalkrJL+qshLlhpMFEuHv8C2d9srZR6Zew3HyofahcR/ppHu0Vq3
         KU0BuzCvZJb26JDaw7tyMmTZbc2gJofs7T9MV9smd6z1mpL4hPW6o8w5pjYYb+axcmtL
         C5Mw==
X-Received: by 10.182.118.104 with SMTP id kl8mr968757obb.54.1363692822949;
 Tue, 19 Mar 2013 04:33:42 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Tue, 19 Mar 2013 04:33:12 -0700 (PDT)
In-Reply-To: <20130318170804.GA15924@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218505>

On Tue, Mar 19, 2013 at 12:08 AM, Jeff King <peff@peff.net> wrote:
>> Is there a reason for the remote not being optional, or are we just
>> waiting for a patch?  The only problem I can foresee is very minor:
>> there is a ref with the same name as a remote; in this case, we'd have
>> to specify both the remote and the ref.
>
> I think the ambiguity is a little more complex than that, because we
> cannot enumerate the universe of all remotes. Keep in mind that we can
> take either a configured remote or a URL (or ssh host). So what does:
>
>   git push foo:bar
>
> mean? Is it pushing "refs/heads/foo" to "refs/heads/bar" on "origin"? Or
> is it using the default refspecs to push to the "bar" repo on the host
> "foo" over ssh?
>
> So you would need some heuristics based on whether something was a valid
> refspec, or could be a valid remote name or URL.

Assume that we agree on what remote is implied, we could simplify
parsing by specifying the remote with "." (or something short and
unambiguous). So the above command would become

git push . foo:bar

Not too much to type
-- 
Duy
