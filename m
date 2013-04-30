From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 17:17:48 -0500
Message-ID: <CAMP44s2S4AtZUfH4NWCLt=p49QXeYSZKELYbahpBUgDofaFMsw@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com>
	<7vppxcdjd1.fsf@alter.siamese.dyndns.org>
	<7vhaindcuk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 01 00:17:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXIrz-0003cP-Ov
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 00:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933746Ab3D3WRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 18:17:52 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:33834 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933600Ab3D3WRv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 18:17:51 -0400
Received: by mail-la0-f48.google.com with SMTP id eo20so880024lab.7
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 15:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=vRi5rqluavjxWroFdItfzgjsgPPafwngWd8mrNvFGMA=;
        b=JD+QSZB4KrfN/t/uBCjn7j8ZSEILvUIIIVqUj+SD7F+0+2QzO3r99ISFw6uqALWzUW
         mHp78oscbE3hXwFet4dEzohN8uY5kXEY6zJgEuc+PUsL+hu10DKkuz481Bgo1+BKldjB
         PIqBCXVl/nXfprijUfv4DmhdFeTH1bLdXuq+V6F6Ts45MdaK7HA8jm0nqXZL9GVDpDj1
         xV+VqMOBeyoHJbEBbCX6ymH2P2mmZxhWwD5PPHCVwHVY6kz0lE9r83wFKrw4CwlFC9SK
         PI113VLyyyVG7KncPH74niUq/XNpfDeS3mMUzU1H0CPmnkhy29HNMOhJ4JcYpK22iv+k
         0QlA==
X-Received: by 10.152.29.132 with SMTP id k4mr65134lah.46.1367360268536; Tue,
 30 Apr 2013 15:17:48 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Tue, 30 Apr 2013 15:17:48 -0700 (PDT)
In-Reply-To: <7vhaindcuk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223027>

On Tue, Apr 30, 2013 at 2:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> On Tue, Apr 30, 2013 at 2:35 AM, Felipe Contreras
>>> <felipe.contreras@gmail.com> wrote:
>>>> So we can type '@' instead of 'HEAD@', or rather 'HEAD'. So now we can
>>>> use 'git show @~1', and all that goody goodness.
>>>
>>> I like this. I haven't spent a lot of time on thinking about
>>> ambiguation. But I think we're safe there. '@' is not overloaded much
>>> like ':', '^' or '~'.
>>>
>>>> This patch allows 'HEAD@' to be the same as 'HEAD@{0}', and similarly with
>>>> 'master@'.
>>>
>>> I'm a bit reluctant to this. It looks like incomplete syntax to me as
>>> '@' has always been followed by '{'. Can we have the lone '@' candy
>>> but reject master@ and HEAD@? There's no actual gain in writing
>>> master@ vs master@{0}.
>>
>> Originally I was going to say the same, but after thinking about it
>> a bit more, I changed my mind.
>
> Let me change my mind once again ;-)
>
> As @ has been a valid character in a ref, I think "git show master@"
> and "git show HEAD@" _should_ error out, not because they suffix
> 'master' and 'HEAD" in a funny way, but simply because there is no
> branch called 'master@' (i.e. 'git for-each-ref | grep master@'
> yields empty).  After you run "git branch master@ master~26", you
> should see "git show master@" not to error out, because that is just
> the name of a branch with somewhat an unusual name.

There is also no branch named master@{0}. And there are no branches
with @{ in them, because we forbid them. So the question is what do we
want to forbid? If we don't want to forbid 'master@', then sure
'master@' should not evaluate to 'master'.

> And we can still have "git show @" to do "git show HEAD", based on a
> world model completely different from I (incorrectly) advocated in
> the message I am replying to.
>
> The rule would be "You should be able to say '@' where-ever you
> currently say HEAD" (aka '@' is a short-hand for 'HEAD').
>
> That means "git checout @" should work the same way as "git checkout
> HEAD", "git log @~4" would work the same way as "git log HEAD~4",
> "git update-ref @ $(git rev-parse master)" should update the HEAD
> without creating $GIT_DIR/@, etc.
>
> You can't go any simpler than that rule, and there is no room for
> confusion if that rule is properly implemented.

I disagree. I can do 'git log @{-1}-4', but I cannot do 'git
update-ref @{-1}'. Why? Because the '@' notation is for revision
parsing, and 'git update-ref' doesn't do revision parsing.

I'd say, everywhere where you could do @{-1}, you should be able to do @.

Cheers.

-- 
Felipe Contreras
