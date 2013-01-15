From: Jardel Weyrich <jweyrich@gmail.com>
Subject: Re: [BUG] Possible bug in `remote set-url --add --push`
Date: Tue, 15 Jan 2013 03:20:53 -0200
Message-ID: <1D472234-A0A5-4F02-878D-D05DEE995FCD@gmail.com>
References: <CAN8TAOsnX1Mr72LPa47KKXDeUZPgSHTJ6u4YpPFPrtsK7VdN+A@mail.gmail.com> <7vliby98r7.fsf@alter.siamese.dyndns.org> <4836187.09xoy3kJnj@blacky> <CAN8TAOv0Cm8CgiJSweFtRzOqO78OtNKa4G+x7z6M5Bt+odUmiQ@mail.gmail.com> <50F40316.7010308@drmicha.warpmail.net> <7v1udnbmyz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Sascha Cunz <sascha-ml@babbelbox.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 06:27:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tuz3O-00063Z-Nx
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 06:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016Ab3AOF06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 00:26:58 -0500
Received: from mail-ye0-f176.google.com ([209.85.213.176]:40942 "EHLO
	mail-ye0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab3AOF05 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2013 00:26:57 -0500
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jan 2013 00:26:57 EST
Received: by mail-ye0-f176.google.com with SMTP id m1so785236yen.35
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 21:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:references:mime-version:in-reply-to:content-type
         :content-transfer-encoding:message-id:cc:x-mailer:from:subject:date
         :to;
        bh=uzTMTDlu9A5JofbVMFeOFIRYAL+E0ROj3mMRQucTBxs=;
        b=YAN4f3X5juyX7ZLtyzlmi3VEu8++js7y53xm9F18D4lwJo0boqMSNgp6h/bHMqJ0e4
         ZqqCmn9258JSlnDWD09wBV3ZsXnG0wTnC+6G30HeHOMVaW8JYPJXmEUpOR3UskysGSF6
         5TNjnD9WpLe0cjX0UteCB8UhJT5eG3ln3y6nrahb4Id1qKaJtvLOFqtDkoc11Eeo1MQW
         YcZ1Z2IWD511MTfi+0h0MuDRXP5ebxZllvMNjwLY6TVg6O+oU0Aq7d411Y/JgZNJimte
         KMwQd261fvujMWydSlUG1lWGT0qJBYRjYalO9pTliViamRFItCyvj1mM+DfCUOiDjtxS
         iXBA==
X-Received: by 10.101.139.38 with SMTP id r38mr28321908ann.29.1358227260477;
        Mon, 14 Jan 2013 21:21:00 -0800 (PST)
Received: from [192.168.1.52] ([187.113.219.47])
        by mx.google.com with ESMTPS id u6sm13231520anq.8.2013.01.14.21.20.57
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 14 Jan 2013 21:20:59 -0800 (PST)
In-Reply-To: <7v1udnbmyz.fsf@alter.siamese.dyndns.org>
X-Mailer: iPhone Mail (10A523)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213574>

On 14/01/2013, at 17:09, Junio C Hamano <gitster@pobox.com> wrote:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> It seems to me that everything works as designed, and that the man page
>> talk about "push URLs" can be read in two ways,...
> 
> Hmph, but I had an impression that Jardel's original report was that
> one of the --add --pushurl was not adding but was replacing.  If
> that was a false alarm, everything you said makes sense to me.
> 
> Thanks.

I failed to explain my reasoning. But I learned quite a bit from this discussion. I understood that the defaul push url is not used by git-push when there's at least one pushurl for a given remote.

If that's by design, I still fail to comprehend the exact reason.
If you allow me, I'd like you to forget about the concepts for a minute, and focus on the user experience.
Imagine a simple hypothetical scenario in which the user wants to push to 2 distinct repositories. He already has cloned the repo from the 1st repository, thus (theoretically) all he needs to do, is to add a new repository for push. He then uses `remote set-url --add --push <2nd-repo>` (which I personally thought would suffice). However, if he tries to push a new commit to this remote, it would be pushed _only_ to the 2nd-repo.

This is exactly what I thought to be a bug. If it's intended to work the way I described in the previous scenario, I'll have to ask and/or research to understand the reason behind this -- Why does having a pushurl make git-push _not_ to push to the default push location (the 1st repo in my scenario) as well? Could you describe a scenario in which that behavior is useful and/or better than the behavior I expected?

Please, pardon me for not being as clear as needed. I appreciate your time on this. Thank you all.

Sent from my mobile.