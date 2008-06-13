From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 10:53:17 +0200
Message-ID: <bd6139dc0806130153u75c53b4do8e7b63f4a7f144e7@mail.gmail.com>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil>
	 <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil>
	 <20080611213648.GA13362@glandium.org>
	 <alpine.DEB.1.00.0806112242370.1783@racer>
	 <20080611230344.GD19474@sigill.intra.peff.net>
	 <co7kgJpJNdIs2f8n_PwYKAS7MwV9t1G_P3BPr1eXTZ4ytUHcsPvVaw@cipher.nrlssc.navy.mil>
	 <20080612041847.GB24868@sigill.intra.peff.net>
	 <u5dYyGz0Q8KNQXnvGOEGmG2BTfT-vJCEFeSUa2I_99Q@cipher.nrlssc.navy.mil>
	 <20080613054840.GA27122@sigill.intra.peff.net>
	 <CA1D4ABE-0B83-44CC-B582-1E85784330AB@wincent.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jeff King" <peff@peff.net>,
	"Brandon Casey" <casey@nrlssc.navy.mil>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Mike Hommey" <mh@glandium.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Wincent Colaiuta" <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 10:54:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7530-0000d9-9k
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 10:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754911AbYFMIxT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2008 04:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755145AbYFMIxT
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 04:53:19 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:40130 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754909AbYFMIxR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jun 2008 04:53:17 -0400
Received: by wf-out-1314.google.com with SMTP id 27so4021075wfd.4
        for <git@vger.kernel.org>; Fri, 13 Jun 2008 01:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=vjoBZmoohMSG6RSspXbOwiO0G96KpJSQ+mr+ZkBLMKI=;
        b=EuAldX40EaeBRIXKeJinv3roGNDAWBV7S8ONsWaCQSCKuh1RlkB4LxUG/EYADEPACp
         Hr7iLHEXstQtrOI4Pyjqyzr5Bnagg12msakkm+zaUqNkRzqBBivhYWyIiOplz+1zy2vL
         zSXbxxCmc40cbFgBm+CfaA8oNG75N7aMP3wZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=qtn9oagbdkSO8SBldYEfEIaUU8wimclzU4oNOn6/gP+J1zUkCSAx9gIeJ2x7xF2QYn
         74OqsA6ACO6Ng+xnQCBkgYzGrPY0iYDE6YdNP1xouukAkNFX7eo8sqX3JBV3DXxbdtE0
         xBb69AJcdkADab+WLDGztAP+1zDmSyXZX1+qQ=
Received: by 10.143.168.4 with SMTP id v4mr975554wfo.39.1213347197246;
        Fri, 13 Jun 2008 01:53:17 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Fri, 13 Jun 2008 01:53:17 -0700 (PDT)
In-Reply-To: <CA1D4ABE-0B83-44CC-B582-1E85784330AB@wincent.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84851>

On Fri, Jun 13, 2008 at 10:41 AM, Wincent Colaiuta <win@wincent.com> wr=
ote:
> El 13/6/2008, a las 7:48, Jeff King escribi=F3:
>> On Thu, Jun 12, 2008 at 11:46:34AM -0500, Brandon Casey wrote:
>>> from reflogs even though stashes are implemented using reflogs.
>>> The big difference is that reflogs are created automatically and
>>> stashes are created by explicit user action. Automatically deleting
>>> something that git creates automatically is ok and desirable, doing
>>> so for something the user explicitly created is not necessarily so.
>>
>> Wincent made this same argument. I don't really agree with it. It is
>> predicated on the assumption that stashing something _is_ asking
>> for git to remember it.

An assumption I agree with:
Use git-stash when you want to record the current state of the working
directory and the index, but want to go back to a clean working
directory. The command saves your local modifications away and reverts
the working directory to match the HEAD commit.

Note the "saves your local modifications", which is, to me, the same
as "please do remember this until I tell you to forget it".

> For me it is quite clear that stashing something _is_ asking for Git =
to
> remember it. It's an explicit user action. It's a request to remember
> something. Whether or not this is actually the best tool for the job =
of
> long-term storage is much less important than the fact that the user
> explicitly requested it. IMO this trumps all other factors. Just beca=
use
> "stash" sounds quicker than "commit" doesn't make it any less of an
> instruction to Git to store something.

I agree fully with what Wincent is saying, stashes have an explicit
way of cleaning them up:
    Remove all the stashed states. Note that those states will then be
subject to pruning, and may be difficult or impossible to recover.
To me this suggests that otherwise stashes will _not_ be subject to
pruning, which is exactly what this patch does, it makes sure that
stashes are not subject to pruning unless you 'git stash clear' first.

--=20
Cheers,

Sverre Rabbelier
