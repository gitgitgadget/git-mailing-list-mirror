From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [RFC] ll-merge: Normalize files before merging
Date: Fri, 11 Jun 2010 10:36:41 +0200
Message-ID: <20100611083641.GB31109@pvv.org>
References: <1276202894-11805-1-git-send-email-eyvind.bernhardsen@gmail.com> <4C11CE75.7080706@viscovery.net> <4C11E717.4070508@gmail.com> <4C11EB0D.20208@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jun 11 10:36:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMzjO-0005Hq-9z
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 10:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759152Ab0FKIgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 04:36:44 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:50549 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755674Ab0FKIgn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 04:36:43 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1OMzjF-0005uT-Ob; Fri, 11 Jun 2010 10:36:41 +0200
Content-Disposition: inline
In-Reply-To: <4C11EB0D.20208@viscovery.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148931>

On Fri, Jun 11, 2010 at 09:51:41AM +0200, Johannes Sixt wrote:
> Am 6/11/2010 9:34, schrieb Eyvind Bernhardsen:
> > On 11. juni 2010 07:49, Johannes Sixt wrote:
> >> I think you are going overboard here. Normalization should only happen
> >> only for data that moves from the worktree to the database. But during a
> >> merge, at most one part can come from the worktree, methinks; you are
> >> normalizing all three of them, though.
> > 
> > Well, that's sort of the point.  All three are normalized to (hopefully)
> > minimize the differences between them, increasing the chance of a
> > successful merge.
> 
> I know what your point is. It is still inappropriate to call
> normalize_file() on data that comes from the repository. It is not the
> task of a merge procedure to blindly normalize data.

I don't think this argument holds. If git doesn't call
convert_to_git() automatically and you get a merge conflict, git WILL
call convert_to_git() on the result anyway when you add it, so it
can't be that horrible that this happens automatically for you?

If you add something to .gitattributes that causes the repository
representation of a file to change, and then try to merge an older
branch, isn't it more helpful if it works than if it fails miserably?

It would probably be more correct to do

conert_to_git(convert_to_work_tree(x)) for the parts taken from base
and theirs, in theory I guess that this can be true:

convert_to_git(x) != convert_to_git(convert_to_work_tree(x))

- Finn Arne
