From: Allan Caffee <allan.caffee@gmail.com>
Subject: [RFC/PATCH v2] graph API: Use horizontal lines for more compact
	graphs
Date: Tue, 21 Apr 2009 08:47:01 -0400
Message-ID: <20090421124701.GA25982@linux.vnet>
References: <alpine.DEB.1.00.0904211010410.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 21 14:48:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwFP4-0003C9-VJ
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 14:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbZDUMrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 08:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbZDUMrK
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 08:47:10 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:45289 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbZDUMrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 08:47:09 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2409290rvb.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2009 05:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=AK6vPY+LJtm+7LxTorJaVzA5sNS5nJeQt9hIJ3UeB1M=;
        b=ZF0/3uiCUMI1p6+PNfu4tZDbWvJRV4r5Zo9psFoB+hbcJyL4aHslxsXFosK3kyV7DT
         M7jpBaI14x7a1vbebyGMmVp37Pxzj3KPvD9hChnJM1WI1XMLEtqhjIMfuRPrkQKPOor2
         +ugiwiw6w4cXlCRlgQKFxpjEYhHvgAMgFyFRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=GZTzgQZMh2rRwz1Tj+D0gp6S11Ay2WHx6Hk058DSy7mYXpb31AxGTqKQaJ+90Gzmg5
         mW3mvEqw/JVszwgAeHvS2T3u2OUKB+Tey8A+jsqMaOzYtj+Gir2Ai7vymU5RtLc14JEp
         op15i3dKdGTuvz/od/u81YMuRq7impGRLy6uM=
Received: by 10.142.88.4 with SMTP id l4mr1642268wfb.334.1240318026631;
        Tue, 21 Apr 2009 05:47:06 -0700 (PDT)
Received: from linux.vnet (pool-71-185-49-127.phlapa.fios.verizon.net [71.185.49.127])
        by mx.google.com with ESMTPS id 24sm693546wff.22.2009.04.21.05.47.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Apr 2009 05:47:06 -0700 (PDT)
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0904211010410.10279@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117128>

Use horizontal lines instead of long diagonal during graph collapsing
and precommit for more compact and legible graphs.

Signed-off-by: Allan Caffee <allan.caffee@gmail.com>
---
 graph.c        |   63 ++++++++++++++++++++++++++++++++++++++++++-------------
 t/t4202-log.sh |    6 +---
 2 files changed, 50 insertions(+), 19 deletions(-)

On Tue, 21 Apr 2009, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 20 Apr 2009, Allan Caffee wrote:
> 
> > On Mon, Apr 20, 2009 at 8:56 PM, Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> >
> > > On Mon, 20 Apr 2009, Allan Caffee wrote:
> > >
> > >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? for (j = (target * 2)+3; j < (i - 2); j += 2)
> > >
> > > This (target*2)+3 is a bit too magical for me to understand. ?But 
> > > maybe I am just too tired?
> > 
> > It is a little magical.  Here target is an index into
> > graph->new_columns so we double that to get the actual location of the
> > edge in the string for this line.
> 
> Ah.  So how about
> 				 /*
> 				  * The variable target is the index of the graph
> 				  * column, and therefore target*2+3 is the actual
> 				  * screen column of the first horizontal line.
> 				  */

Sounds good to me.  Everything else look good?  

Actually now that I look at it, it might be a good idea to put an assert
statement in that for loop like `assert(graph->new_mapping[j] < 0)' to
make sure we don't clobber any existing lines.  But that seems like
overkill since we're already assured to be the first collapsing edge at
that point, which would imply that all previous odd indeces are empty.
WDYT?

diff --git a/graph.c b/graph.c
index d4571cf..86577b4 100644
--- a/graph.c
+++ b/graph.c
@@ -47,20 +47,6 @@ static void graph_show_strbuf(struct git_graph *graph, struct strbuf const *sb);
  * - Limit the number of columns, similar to the way gitk does.
  *   If we reach more than a specified number of columns, omit
  *   sections of some columns.
- *
- * - The output during the GRAPH_PRE_COMMIT and GRAPH_COLLAPSING states
- *   could be made more compact by printing horizontal lines, instead of
- *   long diagonal lines.  For example, during collapsing, something like
- *   this:          instead of this:
- *   | | | | |      | | | | |
- *   | |_|_|/       | | | |/
- *   |/| | |        | | |/|
- *   | | | |        | |/| |
- *                  |/| | |
- *                  | | | |
- *
- *   If there are several parallel diagonal lines, they will need to be
- *   replaced with horizontal lines on subsequent rows.
  */
 
 struct column {
@@ -982,6 +968,9 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 {
 	int i;
 	int *tmp_mapping;
+	short used_horizontal = 0;
+	int horizontal_edge = -1;
+	int horizontal_edge_target = -1;
 
 	/*
 	 * Clear out the new_mapping array
@@ -1019,6 +1008,23 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 			 * Move to the left by one
 			 */
 			graph->new_mapping[i - 1] = target;
+			/*
+			 * If there isn't already an edge moving horizontally
+			 * select this one.
+			 */
+			if (horizontal_edge == -1) {
+				int j;
+				horizontal_edge = i;
+				horizontal_edge_target = target;
+				/*
+				 * The variable target is the index of the graph
+				 * column, and therefore target*2+3 is the
+				 * actual screen column of the first horizontal
+				 * line.
+				 */
+				for (j = (target * 2)+3; j < (i - 2); j += 2)
+					graph->new_mapping[j] = target;
+			}
 		} else if (graph->new_mapping[i - 1] == target) {
 			/*
 			 * There is a branch line to our left
@@ -1039,10 +1045,21 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 			 *
 			 * The space just to the left of this
 			 * branch should always be empty.
+			 *
+			 * The branch to the left of that space
+			 * should be our eventual target.
 			 */
 			assert(graph->new_mapping[i - 1] > target);
 			assert(graph->new_mapping[i - 2] < 0);
+			assert(graph->new_mapping[i - 3] == target);
 			graph->new_mapping[i - 2] = target;
+			/*
+			 * Mark this branch as the horizontal edge to
+			 * prevent any other edges from moving
+			 * horizontally.
+			 */
+			if (horizontal_edge == -1)
+				horizontal_edge = i;
 		}
 	}
 
@@ -1061,8 +1078,24 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 			strbuf_addch(sb, ' ');
 		else if (target * 2 == i)
 			strbuf_write_column(sb, &graph->new_columns[target], '|');
-		else
+		else if (target == horizontal_edge_target &&
+			 i != horizontal_edge - 1) {
+				/*
+				 * Set the mappings for all but the
+				 * first segment to -1 so that they
+				 * won't continue into the next line.
+				 */
+				if (i != (target * 2)+3)
+					graph->new_mapping[i] = -1;
+				used_horizontal = 1;
+			strbuf_write_column(sb, &graph->new_columns[target], '_');
+		}
+		else {
+			if (used_horizontal && i < horizontal_edge)
+				graph->new_mapping[i] = -1;
 			strbuf_write_column(sb, &graph->new_columns[target], '/');
+
+		}
 	}
 
 	graph_pad_horizontally(graph, sb, graph->mapping_size);
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index b986190..a3b0cb8 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -298,14 +298,12 @@ cat > expect <<\EOF
 * | | |   Merge branch 'side'
 |\ \ \ \
 | * | | | side-2
-| | | |/
-| | |/|
+| | |_|/
 | |/| |
 | * | | side-1
 * | | | Second
 * | | | sixth
-| | |/
-| |/|
+| |_|/
 |/| |
 * | | fifth
 * | | fourth
-- 
1.5.6.3
