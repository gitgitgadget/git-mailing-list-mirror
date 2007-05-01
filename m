From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/8] git-repack --max-pack-size: add new file statics
Date: Mon, 30 Apr 2007 21:11:34 -0700
Message-ID: <7vzm4p89op.fsf@assigned-by-dhcp.cox.net>
References: <4636790C.5060908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 01 06:12:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HijjC-00031b-96
	for gcvg-git@gmane.org; Tue, 01 May 2007 06:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933465AbXEAEMO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 00:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933454AbXEAEMJ
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 00:12:09 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:53529 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932398AbXEAELg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 00:11:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070501041135.VDT6556.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Tue, 1 May 2007 00:11:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id tgBa1W00G1kojtg0000000; Tue, 01 May 2007 00:11:34 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45908>

Dana How <danahow@gmail.com> writes:

> This adds "pack_size_limit", which will contain the limit
> specified by --max-pack-size, "written_list", the actual
> list of objects written to the current pack, and "nr_written",
> the number of objects in written_list.
>
> Signed-off-by: Dana L. How <danahow@gmail.com>
> ---
>  builtin-pack-objects.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index b827627..ac2c15e 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -52,7 +52,8 @@ struct object_entry {
>   * nice "minimum seek" order.
>   */
>  static struct object_entry *objects;
> -static uint32_t nr_objects, nr_alloc, nr_result;
> +static struct object_entry **written_list;
> +static uint32_t nr_objects, nr_alloc, nr_result, nr_written;
>  
>  static int non_empty;
>  static int no_reuse_delta;
> @@ -64,6 +65,7 @@ static char tmpname[PATH_MAX];
>  static unsigned char pack_file_sha1[20];
>  static int progress = 1;
>  static int window = 10;
> +static uint32_t pack_size_limit;
>  static int pack_to_stdout;
>  static int num_preferred_base;
>  static struct progress progress_state;
> -- 
> 1.5.2.rc0.766.gba60-dirty

This by itself does not seem to do anything (no logic, no
command line option parsing, nothing).  Why is this a separate
patch?
