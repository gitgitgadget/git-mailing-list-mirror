From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: How to rebase when some commit hashes are in some commit messages
Date: Tue, 13 Oct 2015 14:28:56 -0700
Message-ID: <CA+P7+xpgY-PGdxDKHBeu0X=U6FKMavzmjexUTWatUzEdw8CmcQ@mail.gmail.com>
References: <561C1132.3090606@orange.fr> <vpqsi5fx2gr.fsf@grenoble-inp.fr>
 <561CC5E0.7060206@orange.fr> <20151013160004.11a103942062ee09c53bd235@domain007.com>
 <AD64941D9533442AB025BE27FF8F08AF@PhilipOakley> <CA+P7+xoDia6PC+qJeVn3sD5g4jk7KRuDAPOcEHvrntd+ndUraA@mail.gmail.com>
 <CANoM8SVAGQ4AL9wBiBMaAu0GvaotC8rhn-rWQhLjsyWr4DnXmw@mail.gmail.com> <B846BC4FDE6944D39DC79E245264E544@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mike Rappazzo <rappazzo@gmail.com>,
	Konstantin Khomoutov <kostix+git@007spb.ru>,
	Francois-Xavier Le Bail <devel.fx.lebail@orange.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Oct 13 23:29:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm78L-0003iJ-9a
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 23:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbbJMV3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 17:29:17 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:33430 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079AbbJMV3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 17:29:16 -0400
Received: by iodv82 with SMTP id v82so35934146iod.0
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 14:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aen67+UNVen25lmtv0oQx+yYwv9yoG/DpdQZu1E28Qs=;
        b=ia4PkMltKNdimBvDhzHPJJQ0AWvJVQKQxJoQEyB+r7qzwlltBkSIBkX7YxBHmvZcnQ
         d+WoKqA5Vwu0gLoRz3usgwVlqf1Ik1tZUvsOgw9anrk1NtP762mizZCbn9NKAx8W6Q3i
         734thoJbJQZXNSdACxYPCyLcN3LuAAatesWVcI2PQYK9SAYswZMuBMFInlpA5N3uMaIz
         Jtdzwlm2gM51wxs/6D0MrNzBMFQL5CA2GQBEHF6uu1vIkD5hNhmZKHfASdJ+yYl4Z/ZK
         k6GEGGOvcSM+hNv77dZBc9aSZjzsgRLbeBNN8NPLqDYaIbPNr75jelVA6w3uoI+AybAf
         X2oA==
X-Received: by 10.107.160.208 with SMTP id j199mr221901ioe.146.1444771755846;
 Tue, 13 Oct 2015 14:29:15 -0700 (PDT)
Received: by 10.107.140.2 with HTTP; Tue, 13 Oct 2015 14:28:56 -0700 (PDT)
In-Reply-To: <B846BC4FDE6944D39DC79E245264E544@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279524>

On Tue, Oct 13, 2015 at 12:24 PM, Philip Oakley <philipoakley@iee.org> wrote:
> IIUC (as an alternate example),  in G4W one can submit a (long) pull request
> with internal back references that would be merged directly, so the sha1's
> could be updated as Francois-Xavier originally asked. I have a series that's
> been bumping along for a long while that needs regular rebasing, though
> doesn't have sha1 back references, so I can see that the need does happen. I
> can see that others may have a workflow that would work well with the sha1
> auto-update.
>
> --
> Philip
>

I still don't see how this is useful, because the part that *can* be
implemented is not valuable and the part that is valuable can't be
implemented.

So, what we can implement easily enough:

you rebase a series and any time the message contains sha1 of a commit
we're modifying in this rebase, we update the sha1 to match again.
This seems reasonable, but not useful. Why would you reference a
commit that is *ITSELF* being rebased. No one has explained a
reasonable use for this... I'm sure there exists one, but I would want
an explanation of one first.

The "useful" case is if you rebase "onto" a tree that has a previous
history that has been changed. In this case, how do you propose we
find it. Doing as suggested above, ie: only changing sha1s that we are
already rebasing works, but why are you backreferencing it if you are
re-writing the commit? That doesn't make sense to me at all. Yes, you
can do it, but I don't get why this is valuable. If you're backref is
"fixes xyz" why not just fix xyz instead of have two commits. If the
back ref has some other value... what is that value? I don't
understand it I guess.

It just seems pretty narrow focus. I mean if someone wants to
implement it, that is fine.

Regards,
Jake
