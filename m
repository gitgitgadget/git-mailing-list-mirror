From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 5.5/22] Add documentation for the index api
Date: Thu, 11 Jul 2013 19:27:25 +0700
Message-ID: <CACsJy8AL2FrHRokjRKnFuAsgdiLdwPZo-OU75YOv+7XNvVXbXw@mail.gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
 <1373184720-29767-6-git-send-email-t.gummerer@gmail.com> <CACsJy8C0F+v3g+gPon6Y8+z7ObN1Jv8Ln==RNrVsRp7aya74hw@mail.gmail.com>
 <87pputqowr.fsf@gmail.com> <CACsJy8CtOWjpxKuNhQXYjPAv8MU0U6yTBEuQeqm0kxqVne6NjQ@mail.gmail.com>
 <871u78rcw0.fsf@gmail.com> <CACsJy8A9+1O_em=FtV_TUKags4FrSggV76dd1h6gsJ+JHfjZKw@mail.gmail.com>
 <87wqozpk9s.fsf@gmail.com> <CACsJy8BRw6jqB1XBzDcCr3UXNGG1wRPjwnMrh+EksFf7VsQysg@mail.gmail.com>
 <87ppupcp19.fsf@gmail.com> <CACsJy8DNQ5Sr4a7PZMX4G-pf+fHqR398b3mncCZtQ-BBBpD+RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 14:28:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxFya-0005L7-TU
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 14:28:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755818Ab3GKM14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 08:27:56 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:50999 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755418Ab3GKM14 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 08:27:56 -0400
Received: by mail-oa0-f52.google.com with SMTP id g12so11214606oah.11
        for <git@vger.kernel.org>; Thu, 11 Jul 2013 05:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=21asHfU7EV7r2Sk11fzXcYzGReneix2SAdKRvJqtdeA=;
        b=xZUFTr0QRBBiPXnGQHRzQVveBARCLQnMDEUT8+Y09B8nhqGz+LLPTgWttm/Iv0lfcP
         AOKPqsNrwVFqV+W+G4GwjFXqihJe0YZ7k/MGgPXTZSg2Pr40JVpn1fdioL/hRrTvPz+8
         X2+JGp8HGZfoWgbttp0vYJfpGM+KnKbr9VRWTv/R5j1Mfc0+75TPoyFoWiqGeO9EUohj
         0JreinJHmP8A77RVkn99nDiU+l5c7OYfVdByoLIclv6IsM4B/Rj1UWpJplIJYD/XMwPb
         ScSb3GrGVz5wdSe3zXYvTMPvv/hF82J0evYDfePib+U/B3eUxGW/zQtiM2I5pv186yJq
         pcSg==
X-Received: by 10.182.215.133 with SMTP id oi5mr31617585obc.83.1373545675496;
 Thu, 11 Jul 2013 05:27:55 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Thu, 11 Jul 2013 05:27:25 -0700 (PDT)
In-Reply-To: <CACsJy8DNQ5Sr4a7PZMX4G-pf+fHqR398b3mncCZtQ-BBBpD+RQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230098>

On Thu, Jul 11, 2013 at 6:42 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Jul 11, 2013 at 6:30 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>> Hrm, I played around a bit with this idea, but I couldn't figure out how
>> to make it work.  For it to work we would still have to load some
>> entries in a directory at least?  Or is there a way to match the
>> directories, which I just haven't figured out yet?
>
> Yes you have to load some entries first. Even if a directory does not
> match, we only know until at least the first file in the directory. OK
> there might be problems because tree_entry_interesting expects all
> entries in a directory to be memcmp sorted, without trailing slash for
> subdirectories. I need to check again if v5 sort order is compatible..

Not gonna work (at least not simple) because we have to mix
directories and files again. The way directory entries are ordered
makes it hard (or less efficient) to get the list of immediate subdirs
of a dir. I think I understand now why you need adjusted_pathspec..
--
Duy
