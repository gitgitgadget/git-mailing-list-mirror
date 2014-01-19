From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] Fix safe_create_leading_directories() for Windows
Date: Sun, 19 Jan 2014 08:26:33 +0100
Message-ID: <CAHGBnuNoTrRwnjp7ZqMgveLHZeV68cxOqawf7nWo7gnAAYfSOw@mail.gmail.com>
References: <52C5A039.6030408@gmail.com>
	<alpine.DEB.1.00.1401021826120.1191@s15462909.onlinehome-server.info>
	<xmqqtxdmp39a.fsf@gitster.dls.corp.google.com>
	<52C5D0AB.7050309@gmail.com>
	<xmqqha9mozvc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 19 08:27:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4mmZ-0001ls-N0
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jan 2014 08:27:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbaASH0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jan 2014 02:26:35 -0500
Received: from mail-qa0-f43.google.com ([209.85.216.43]:54650 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbaASH0e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jan 2014 02:26:34 -0500
Received: by mail-qa0-f43.google.com with SMTP id o15so4650485qap.16
        for <git@vger.kernel.org>; Sat, 18 Jan 2014 23:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=a7woNWkhbdAoiJz5zj6g9fs7uvdYLm1vXGfzR1jp+EM=;
        b=tM0TsTvr+hoE7PcJ2Z7rw0uZAbuPVa8jMQdzW3AOd4Twm0l9rozTCQC8hd23LfUISm
         ANl+trtAarug8cDdNCq9NaVzpRMvGwUjiuDIW2OOT8tUKszbmX0Um72eZPXfIwWqRywJ
         kJvnZo+GJcrr0G16yikw7T714N6g1wfHdaNFQTrkUQySBVFbl/FDYdxfbwArUET+coCt
         mbWrzrVe/gZ8Vqbqh24aD424mqFGINO+wfu2y2bitRk1w1TV1CCLh5+64scipRtFrbb+
         nnCBKFkFE37+9QnI/YBWFjmq7BjwGNzukrMqzXm29ZOxNPcxpW3hKHI6Am4H4PsxM3Ug
         62Rw==
X-Received: by 10.229.24.4 with SMTP id t4mr17848396qcb.13.1390116393991; Sat,
 18 Jan 2014 23:26:33 -0800 (PST)
Received: by 10.96.22.229 with HTTP; Sat, 18 Jan 2014 23:26:33 -0800 (PST)
In-Reply-To: <xmqqha9mozvc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240674>

On Thu, Jan 2, 2014 at 10:08 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> Seems like the path to clone to is taken as-is from argv in
>> cmd_clone(). So maybe another solution would be to replace all
>> backslashes with forward slashes already there?
>
> That sounds like a workable alternative, and it might even be a
> preferable solution but if and only if clone's use of the function
> to create paths that lead to a new working tree location is the only
> (ab)use of the function.  That was what I meant when I said "it may
> be that it is a bug in the specific caller".  AFAIK, the function

I think Dscho made valid points in his other mail that the better
solution still is to make safe_create_leading_directories() actually
safe, also regarding its arguments.

-- 
Sebastian Schuberth
