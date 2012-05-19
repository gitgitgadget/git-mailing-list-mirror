From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 2/2] submodule: fix handling of supermodules with relative
 origin URLs
Date: Sun, 20 May 2012 09:10:15 +1000
Message-ID: <CAH3AnrrxgT1OQe-K2A91XfMLSd2WGvJ5CzyNR4tRqvYfp4wgQg@mail.gmail.com>
References: <1337402403-7546-1-git-send-email-jon.seymour@gmail.com>
	<1337402403-7546-2-git-send-email-jon.seymour@gmail.com>
	<4FB7ECCF.9020403@web.de>
	<CAH3AnrrqiXqdHHGZPyOPJ3Zend5JrQX0rKV+pz_mjs3SDjv9DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun May 20 01:10:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVsnZ-00075e-Sv
	for gcvg-git-2@plane.gmane.org; Sun, 20 May 2012 01:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756822Ab2ESXKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 May 2012 19:10:18 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:41103 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754872Ab2ESXKR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2012 19:10:17 -0400
Received: by wibhj8 with SMTP id hj8so1215216wib.1
        for <git@vger.kernel.org>; Sat, 19 May 2012 16:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XFUaIP9VxtGW7PxriEp8ONr/V1satFgDTIbQMXkWknk=;
        b=YsO1+unFcQddb5A51MP8ollvEYTO2dR6TCtjEfiE+ykNj1wYvSbK5Eou6KFqNoHDpR
         oLCBIrmcnoVQ8fJ65GOP3zL4GxseNS0sznGjrdTfEYlmjexb4RZL2sZZRT2NAWF1kC4N
         ci/G0/WVFLUkE8MyT5MT8Sof2hnQNpfVBi7P5BEycJzKFxMAdAKtMsmaL5YV7+J4c79u
         kaeBDFhrNobPRvnjkqr1FZX5TgGuX60thjrWU4gOk9Hs1Elmr+7K5w8DcjGEY9AiOch8
         qmHlMe1NTI5i0cANPPvcmYcS8OHFWEVAT7NgUsmRvzhCp4fwV+asIO4M9tNUCCwFQpV0
         mtzQ==
Received: by 10.180.86.197 with SMTP id r5mr12659268wiz.21.1337469015912; Sat,
 19 May 2012 16:10:15 -0700 (PDT)
Received: by 10.180.146.166 with HTTP; Sat, 19 May 2012 16:10:15 -0700 (PDT)
In-Reply-To: <CAH3AnrrqiXqdHHGZPyOPJ3Zend5JrQX0rKV+pz_mjs3SDjv9DA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198044>

On Sun, May 20, 2012 at 8:51 AM, Jon Seymour <jon.seymour@gmail.com> wrote:
> On Sun, May 20, 2012 at 4:56 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Am 19.05.2012 06:40, schrieb Jon Seymour:
> I noticed one relative case that is not handled properly yet, but
> there is a workaround. If the superproject's origin URL is of the
> form: foo/bar (a case I actually have myself for reasons I can explain
> if you want me to), then the correct rule doesn't get matched by
> .*/*). The workaround is for the user to change foo/bar style origin
> URLs to ./foo/bar.
>
> Let me know if I should fix this case now too.

I think this expression:

    remoteurl=$(echo "remoteurl" | sed "s|^[^/][^:]*\$|./&|" )
    remoteurl=${remoteurl%/}

would normalize remoteurl correctly for the foo/bar case and not any other.

I'd also need to add at least one new test (or do I actually need 3?),
of course.

jon.
