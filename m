From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: Undo a git stash clear
Date: Tue, 16 Dec 2008 12:12:52 +0000
Message-ID: <57518fd10812160412j1edc2ea0mff732825f1f6c4a2@mail.gmail.com>
References: <c6c947f60812160407l1b2593e1pde817f5cfb091d59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, git-users@googlegroups.com
To: "Alexander Gladysh" <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 13:14:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCYoV-0007lM-TF
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 13:14:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462AbYLPMMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 07:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754298AbYLPMMz
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 07:12:55 -0500
Received: from wf-out-1314.google.com ([209.85.200.168]:52126 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858AbYLPMMx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 07:12:53 -0500
Received: by wf-out-1314.google.com with SMTP id 27so3179525wfd.4
        for <git@vger.kernel.org>; Tue, 16 Dec 2008 04:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=h7qAmbG9Bu5UT36dUx0ibyNXm/843B/2ODIy6FbP3Uo=;
        b=k0W4HROWCt+Uav+nhSvTYYYoyU76h6CdbCD/bQ+lzyvvldA8SG4HaN9ZuVQdDyLFyo
         WBNzsoAK3gZn+oyVl3ZdV59Kr1lvdpcDJUQq0SawEZ580ubQFeSiyv1tPkVDKrundCDZ
         dByTUJPCocbFCt6WJ6EjkL6DcZsVup1lfpsFI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=mDxypDWFB78jyAXvUkmFxoDwcAvCl5B1hiaaSMCtN6TV2lOjHlVLIOLqHL7iVaqbSl
         t6d251T8aZ8/62Pnpb3QgtqldzLsaKJnTD4ogbjGbVno5JkgnuU5Biv+jQelrONgX8xL
         eOFWUns3lH/A9VNeOYWB3joIdmZo61v9FnQJk=
Received: by 10.142.125.9 with SMTP id x9mr3289970wfc.38.1229429572485;
        Tue, 16 Dec 2008 04:12:52 -0800 (PST)
Received: by 10.143.35.2 with HTTP; Tue, 16 Dec 2008 04:12:52 -0800 (PST)
In-Reply-To: <c6c947f60812160407l1b2593e1pde817f5cfb091d59@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 5454a3b72b55636f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103276>

On Tue, Dec 16, 2008 at 12:07 PM, Alexander Gladysh <agladysh@gmail.com> wrote:
> Hi, list!
>
> I've stashed some valuable changes and then I accidentally did git
> stash clear. (Yes, today is not my day).
>
> Is it possible to restore stashed changes?

I ran into this exact problem on Friday.  Some helpful person on IRC
suggested using

git fsck | grep commit | cut -d' ' -f3 | while read hash; do git
rev-parse --verify --quiet $hash^2 && echo $hash; done | xargs git
show

Which will show a huge list of lost changes.  Once you find the change
you're interested in, you can cherry-pick its sha1.
