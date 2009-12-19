From: "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com>
Subject: Re: Git as electronic lab notebook
Date: Sat, 19 Dec 2009 15:38:32 +0200
Message-ID: <8e04b5820912190538v2e9ef109me3a1515040127b39@mail.gmail.com>
References: <loom.20091219T130946-844@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Johnson <thomas.j.johnson@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 14:38:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLzW4-0000rY-Bj
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 14:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbZLSNif convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Dec 2009 08:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752131AbZLSNif
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 08:38:35 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:64571 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107AbZLSNie convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Dec 2009 08:38:34 -0500
Received: by ewy19 with SMTP id 19so2441397ewy.1
        for <git@vger.kernel.org>; Sat, 19 Dec 2009 05:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DiDU3ljcu170Vxh4G0uZ+aP4unbTQ0Ni6iNhN6J/Tqc=;
        b=kF55l2DGGoccnc+PIC5+1iSa+WoEJz76xEQ0gs2n0XrGWzB8aedaKQEDVhKSZJuR4k
         KnDuQBe5MD8MtIWZ6VDJuK2KC1iylPNGHvQn6jfMHvrgAbxfX3s04eAPcD45P3IeTWw2
         cRf/xc9bo/29fz8lS2PkNIdaoi6TchBDV+GOc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qM/W9mHkEp3NJh83QsuPgHkuecWzEuuKC5ZK6rjVMk3CEu7h/4CsxTjdTTpBrKQblC
         /lA72PO3irXm5Vvp6qkzlgwpfnAGslylAbHjz5eqcuLRUs6SgjIy0L3upQCzJdzV8PQ4
         DBcTKEy5oJIluoymyeGIKCvdQ3SlN9MtegBM0=
Received: by 10.213.37.19 with SMTP id v19mr280555ebd.64.1261229912837; Sat, 
	19 Dec 2009 05:38:32 -0800 (PST)
In-Reply-To: <loom.20091219T130946-844@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135481>

On Sat, Dec 19, 2009 at 2:23 PM, Thomas Johnson
<thomas.j.johnson@gmail.com> wrote:
> Hello group,
>
> I've been using git on a few different projects over the last couple =
of months,
> and as a former svn user I really like it. Recently, I've been using =
it as an
> 'electronic lab notebook' for an empirical project. My workflow looks=
 like this:
> 1. Start with the stable code base on head
> 2. Create =C2=A0and change to branch 'Experiment123'
> 3. Make some changes
> 4. Run the program, which generates a giant (10MB-4G) output text fil=
e,
> Experiment123.log. Update my LabNotebook.txt file.
> 5. Were the new changes helpful?
> 5.yes: Bzip Experiment123.log, and commit it on the branch. Merge the
> Experiment123 branch to head and goto 1.
> 5.no: Bzip Experiment123.log, and commit it on the branch. Merge LabN=
otebook.txt
> and Experiment123.log back to head. Switch back to head and goto 1.
>
> The thing is, Experiment123.log is going to be very similar to Experi=
ment122.log
> and Experiment124.log except for a few details. My understanding is t=
hat git is
> great at compressing groups of files like this, is that correct? Shou=
ld I not be
> bzipping them myself? On the other hand, I don't want HEAD to contain=
 hundreds
> of gigs of uncompressed files that bzip down to only a few hundred me=
gs.
>
> Any thoughts on the workflow itself would also be very welcome.


    I have used myself such a similar workflow for parametric studies
on some genetic algorithms, and below are my observations related to
your question:
    * saving the entire log file (either zipped or not) in the
repository has some drawbacks with repository clonning; (in my setup
I've runned the tests in parallel on a different machine, and used Git
to synchronize between the development machine and the test machine;)
the problem lies in the fact that when I wanted to "clean" the test
machine and start over I had to clone the repository, which also held
all the unneeded log files;
    * (actually I've used two Git repositories -- one for the actual
source code where I make the commits by hand, and another one which I
use for the synchronization;)
    * even if you prefer having the logs, it's best to let Git handle
the compression; because even if only some small parts change from the
original txt file, I would guess that the BZip-ped file looks quite
different;
    * maybe it would be better than instead of holding the experiment
log, you just keep a sumarization of it (only the important stuff);
and even if you do need the entire log, you could always recreate it
by running the code again; (this was the road I took in the end, by
keeping a small SQLite database of each experiment;)
    * (and of course there is also another little trick I've used:
just put the logs file in a `log` directory which is "git-ignored",
that way you can switch between branches, but Git won't touch the
`log` directory, unless you force it by issuing `git clean -f -d -x`;)

    Hope I've been useful,
    Ciprian.
