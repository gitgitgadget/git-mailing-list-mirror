From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFD: a submodule-like facility that tracks branches rather than 
	commits
Date: Mon, 3 May 2010 08:39:42 +1000
Message-ID: <l2u2cfc40321005021539v573e58a5j15696d81b5e5acd5@mail.gmail.com>
References: <w2n2cfc40321005020402gdc210b79v2652afa849cf7a60@mail.gmail.com>
	 <7veihuuwdj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 03 00:41:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8hqv-0005XU-5S
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 00:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758558Ab0EBWjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 18:39:44 -0400
Received: from mail-qy0-f189.google.com ([209.85.221.189]:45998 "EHLO
	mail-qy0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757469Ab0EBWjn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 18:39:43 -0400
Received: by qyk27 with SMTP id 27so5039711qyk.23
        for <git@vger.kernel.org>; Sun, 02 May 2010 15:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=j+KQIxUMbRED3EI79u0vv3dRDrfrtLdVR8+vmKlTHjQ=;
        b=M+PzPbSnNb3JwyoGQ/ShZ0lm3j0h+HtkWeqXL41qxiW2WD8pDhOBZowBFdFql1pOR6
         QqVZmI7+a0SLe3WR5eyWhX0IPYQYfJdcWNQYnjcNvgjhLxe1HetB1I+sKxH1hbnuMYbf
         k01GeKLIrzStMtpYpJGboEy3KlXZVhvajgOI4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=YCBvbHJTEem4CdRMl6xSWlHE4EIKTvKn+hfEQMXdrcUykaDHml+4C9ZgVCcmq0oYaR
         30BZKdbbRz4dSVw+MyN0++HmFRn0GOXiKzsGa3S5FCDUA2Elu6Rax8QbyBBA5M3iU4Su
         8rhINZW3ZLcdJCj3naoUg56LWtYnj2JFufaRg=
Received: by 10.229.217.148 with SMTP id hm20mr1412777qcb.38.1272839982665; 
	Sun, 02 May 2010 15:39:42 -0700 (PDT)
Received: by 10.229.224.65 with HTTP; Sun, 2 May 2010 15:39:42 -0700 (PDT)
In-Reply-To: <7veihuuwdj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146204>

On Mon, May 3, 2010 at 2:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jon Seymour <jon.seymour@gmail.com> writes:
>
>> Has consideration ever been given to a submodule-like facility where
>> the configuration information maintained in the supermodule for the
>> submodule is not a gitlink but is instead the name of a branch (or
>> generally, a symbolic reference within the nested submodule).
>
> I think this comes up from time to time, and there was an even a slightly
> more concrete suggestion to us 0{40} in the tree object to denote such an
> entry.
>
> But once people realize that there is no single canonical authoritative
> repository whose branch heads point at the same commits for everybody in a
> distributed environment, the line of thought to touch gitlink entries gets
> retracted or discarded as a misguided idea.
>

I understand the point about there being no canonical authority,
particularly in a truly distributed environment - any use of branches
would have to imply that users followed some convention when
publishing the entire set.

On the other hand, there is actually precedent for use of convention
like that in the submodule facility - the use of relative paths to
describe the relative locations of submodule repos only really works
if everyone who publishes the supermodule uses the filesystem
structure for the directories containing the super- and sub-module
repos.

> I however don't think it would hurt to enrich .gitmodules with not just
> the repository information but with branch information to help clones
> decide which commit (other than what is recorded in the tree of the
> superproject's commit) on the named remote tracking branch to try out with
> the superproject's commit.
>
>

I can see that this could work. Presumably git submodule sync would be
modified in this case to help switch branches.

Also needed, I think, would be a way to sync the .gitmodule file with
the current submodule branch assignments.

I guess there is no reason why I cannot prototype a facility of this
kind with a local helper script. If I it ends up being useful, I'll
consider posting a patch.

jon.
