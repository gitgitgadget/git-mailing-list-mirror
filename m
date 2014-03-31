From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: What's cooking in git.git (Mar 2014, #07; Fri, 28)
Date: Mon, 31 Mar 2014 10:56:13 -0700
Message-ID: <CAL=YDWnKb7Di3wsw7i1kn0mCGAmqvSY+xQOA5wo2v_EohkHEEg@mail.gmail.com>
References: <xmqqtxai7ym6.fsf@gitster.dls.corp.google.com>
	<53360457.1060008@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Brad King <brad.king@kitware.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 31 19:56:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUgRZ-00053N-3r
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 19:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201AbaCaR4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 13:56:16 -0400
Received: from mail-vc0-f172.google.com ([209.85.220.172]:64704 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627AbaCaR4O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 13:56:14 -0400
Received: by mail-vc0-f172.google.com with SMTP id la4so8648826vcb.31
        for <git@vger.kernel.org>; Mon, 31 Mar 2014 10:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=JufqZTA4TP3I87KK0aGuHMy19ZiU5XdXA04PQaAQCs0=;
        b=jQ/i6/BLzwOm3yKwbv5iv43VhfGOceDg7iy0FnVGG0xJ4T6bwtDh6QhGjghw7vDBVI
         SAlXnJEdNWQ6JFB9d4Nu+Cr6XAqU7Ale4el9kMlF/UTmohyjIz4YbZEV4HpmrDcDlOpr
         LvqX7v85gtAZvZJ6sPgVuGecIOBasW70jri/Tx/SDJdHBf7bMcylgF3nwlK8MvHE31E8
         beEDzQirZ6Pkt8o/jSGw/mpI43B+EdBUCuh5tnwa+M6+JKKDBawp6lMZU/mns3h+jc4P
         irs4lDaQwFEQ15I5GAY899RkDaImYhjMBMOsguyLDekrHGvlweSyC1iPIu5BDG85mktl
         6rew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=JufqZTA4TP3I87KK0aGuHMy19ZiU5XdXA04PQaAQCs0=;
        b=cg+Nuw8wSFSO/FLZUVRvhjf0gMAp2PUCJDnpX8xq1cnVeIIKBcXvM/fs9arBzlBUcL
         2mafTXQ0pxOx5la3kS5JNLF8MBNOPie5RfHzEgLmu1qke6NL+cut4v56Kp9IJdbE7ptq
         vMWDxBWYLMAa2KY164YAHrtre6nKzQ3Rz22nJyEhhuMYUzH3palnHroCgdJL6NNmCdQh
         utAVvRh+CJTBChE1KNEtHw4mLfrv8klg6ex6OXoDOl4qLj4MYIQkvv+iAtC59N/geTIg
         IAhKR+bYbdmF8tv3HJKuBP1NTEn2hJ0Ydp7zK+QetCL5xa1ERqZ5DXetJa/IxiMmGzMD
         40wg==
X-Gm-Message-State: ALoCoQnQhUe55RmsIsYYAKFrEldxHTBnNzMONnnCUzbD2GARJzIRVYmHu0SQJK+YQJXAPk8goefHoO1JNgFAuIDguSvfaDPk+/HEVBc/GwbUKtEzc9usVVTUrEnUxQ9uOcJOqnW0rGetoxdmL6HhhyVRyChDy5CThwtUHorJ45YykOIjnEcVAGkzgTEyNjlGcsywncouL2Q4
X-Received: by 10.53.1.69 with SMTP id be5mr1931462vdd.27.1396288573867; Mon,
 31 Mar 2014 10:56:13 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Mon, 31 Mar 2014 10:56:13 -0700 (PDT)
In-Reply-To: <53360457.1060008@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245499>

(now without HTML formatting)

I am new to git, so sorry If I overlooked something.

I think there might be a race in ref_transaction_commit() when
deleting references.


/* Perform deletes now that updates are safely completed */
for (i = 0; i < n; i++) {
struct ref_update *update = updates[i];

if (update->lock) {
delnames[delnum++] = update->lock->ref_name;
ret |= delete_ref_loose(update->lock, update->type);
}
}

ret |= repack_without_refs(delnames, delnum);
for (i = 0; i < delnum; i++)
unlink_or_warn(git_path("logs/%s", delnames[i]));


These two blocks should be reordered so that you first delete the
actual refs first, while holding the lock and then release the lock
afterward ?

On Fri, Mar 28, 2014 at 4:23 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 03/28/2014 11:21 PM, Junio C Hamano wrote:
>> Here are the topics that have been cooking.  Commits prefixed with
>> '-' are only in 'pu' (proposed updates) while commits prefixed with
>> '+' are in 'next'.
>
> Junio,
>
> Have you overlooked my ref-transactions series [1], or just not gotten
> to it yet?
>
> If you would like a version of the series that already addresses Brad
> King's comments, you can get it from my GitHub fork [2], the
> "ref-transactions" branch.  I'd be happy to post a v3 to the list if you
> prefer, but the only changes since v2 were to a commit message and a
> comment so it seems like overkill.
>
> Michael
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/244857
> [2] https://github.com/mhagger/git
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
