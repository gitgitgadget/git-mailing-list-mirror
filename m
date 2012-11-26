From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: git bundle format
Date: Mon, 26 Nov 2012 21:20:15 +0100
Message-ID: <CAMP44s03QiO15jODBD4JO_JF8tCOT9OJG1tb4+r+L4dgPUOLFg@mail.gmail.com>
References: <871B6C10EBEFE342A772D1159D13208537ABF5AB@umechphj.easf.csd.disa.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>
X-From: git-owner@vger.kernel.org Mon Nov 26 21:20:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td5AR-0007xE-IZ
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 21:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756072Ab2KZUUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 15:20:17 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:32785 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755970Ab2KZUUQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Nov 2012 15:20:16 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so6066404vbb.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 12:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=yI4mWQOAp9eqrdWxlS0cQTcHZivKhzOTF5xKLRrnU5g=;
        b=Wf0yGJyqEi2uSy/laTUYjVIYW3ZmGRwMWpjagX2VFH7ok6MCcrs+ScE89GwjY5R0Qy
         JGB0lvEBsunTa8avtQgT3JSAti/wnPVg7uE0uxuXGG8ie3yz7Zczd8Jj6fu84rMWaYex
         dY/2eG2dOmcEy6dahdrzjRUTgerm3tMY/R9WQ2X+iCTtmHbfVFv5SznOLhK0r5SOypVw
         c7XLSE0D/yYZZHdqUxZBB7NnJFgBxBOHCdZn6zBK5zpOejRzksiuX0RYye/E6H9uYYHK
         p9flT5DSGMAq2V21vt4MzW2nk0y0QQzodgTzlN8mDrGH3oQds70jwyBrcJfkx/bf3Obe
         N6xg==
Received: by 10.58.145.161 with SMTP id sv1mr21386024veb.52.1353961215628;
 Mon, 26 Nov 2012 12:20:15 -0800 (PST)
Received: by 10.58.34.51 with HTTP; Mon, 26 Nov 2012 12:20:15 -0800 (PST)
In-Reply-To: <871B6C10EBEFE342A772D1159D13208537ABF5AB@umechphj.easf.csd.disa.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210478>

On Mon, Nov 26, 2012 at 8:24 PM, Pyeron, Jason J CTR (US)
<jason.j.pyeron.ctr@mail.mil> wrote:
> I may need to be nudged in a better direction, but please try to understand my intentions.
>
> I am facing a situation where I would like to use git bundle but at the same time inspect the contents to prevent a spillage[1].
>
> Given we have a public repository which was cloned on to a secret development repository. Now the developers do some work which should not be sensitive in any way and commit and push it to the secret repository.
>
> Now they want to release it out to the public. The current process is to review the text files to ensure that there is no "secret" sauce in there and then approve its release. This current process ignores the change tracking and all non-content is lost.
>
>
> In this situation we should assume that the bundle does not have any content which is already in the public repository, that is it has the minimum data to make it pass a git bundle verify from the public repositories point of view. We would then take the bundle and pipe it though the "git-bundle2text" program which would result in a "human" inspectable format as opposed to the packed format[2]. The security reviewer would then see all the information being released and with the help of the public repository see how the data changes the repository.
>
> Am I barking up the right tree?

Have you tried 'git fast-export'? The output is definitely not human
inspectable, but should be relatively easy to parse to generate such a
format. And instead of 'git bundle unbundle' you could use 'git
fast-import'. or simply do the conversion in your script.

Cheers.

-- 
Felipe Contreras
