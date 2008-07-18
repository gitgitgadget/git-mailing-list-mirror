From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 04/28] Move org.spearce.jgit.pgm to its own Java project
Date: Thu, 17 Jul 2008 21:43:57 -0400
Message-ID: <1216345461-59382-5-git-send-email-spearce@spearce.org>
References: <1216345461-59382-1-git-send-email-spearce@spearce.org>
 <1216345461-59382-2-git-send-email-spearce@spearce.org>
 <1216345461-59382-3-git-send-email-spearce@spearce.org>
 <1216345461-59382-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 03:46:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJf2n-00060p-FS
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 03:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758376AbYGRBox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 21:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758383AbYGRBov
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 21:44:51 -0400
Received: from george.spearce.org ([209.20.77.23]:46946 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757017AbYGRBoa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 21:44:30 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id B4FCF38448; Fri, 18 Jul 2008 01:44:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 221E7382A4;
	Fri, 18 Jul 2008 01:44:24 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.3.569.ga9185
In-Reply-To: <1216345461-59382-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88955>

This way the library does not need to depend upon args4j, as the
core library does not need a command line option parser.  We now
have a more complex link to build the stand-alone jgit shell script
so JarLinkUtil exists to combine multiple JARs and class directories
into a single output ZIP file.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 jgit.sh                                            |    2 +
 make_jgit.sh                                       |   88 +++++-
 org.spearce.jgit.pgm/.classpath                    |    8 +
 org.spearce.jgit.pgm/.gitignore                    |    1 +
 org.spearce.jgit.pgm/.project                      |   17 +
 .../.settings/org.eclipse.core.runtime.prefs       |    3 +
 .../.settings/org.eclipse.jdt.core.prefs           |  320 ++++++++++++++++++++
 .../.settings/org.eclipse.jdt.ui.prefs             |    9 +
 .../src/org/spearce/jgit/pgm/Die.java              |    0
 .../src/org/spearce/jgit/pgm/DiffTree.java         |    0
 .../src/org/spearce/jgit/pgm/Fetch.java            |    0
 .../src/org/spearce/jgit/pgm/Glog.java             |    0
 .../src/org/spearce/jgit/pgm/IndexPack.java        |    0
 .../src/org/spearce/jgit/pgm/Log.java              |    0
 .../src/org/spearce/jgit/pgm/LsRemote.java         |    0
 .../src/org/spearce/jgit/pgm/LsTree.java           |    0
 .../src/org/spearce/jgit/pgm/Main.java             |    0
 .../src/org/spearce/jgit/pgm/MergeBase.java        |    0
 .../src/org/spearce/jgit/pgm/Push.java             |    0
 .../src/org/spearce/jgit/pgm/RevList.java          |    0
 .../org/spearce/jgit/pgm/RevWalkTextBuiltin.java   |    0
 .../src/org/spearce/jgit/pgm/ShowRef.java          |    0
 .../src/org/spearce/jgit/pgm/Tag.java              |    0
 .../src/org/spearce/jgit/pgm/TextBuiltin.java      |    0
 .../org/spearce/jgit/pgm/build/JarLinkUtil.java    |  204 +++++++++++++
 25 files changed, 635 insertions(+), 17 deletions(-)
 create mode 100644 org.spearce.jgit.pgm/.classpath
 create mode 100644 org.spearce.jgit.pgm/.gitignore
 create mode 100644 org.spearce.jgit.pgm/.project
 create mode 100644 org.spearce.jgit.pgm/.settings/org.eclipse.core.runtime.prefs
 create mode 100644 org.spearce.jgit.pgm/.settings/org.eclipse.jdt.core.prefs
 create mode 100644 org.spearce.jgit.pgm/.settings/org.eclipse.jdt.ui.prefs
 rename {org.spearce.jgit => org.spearce.jgit.pgm}/src/org/spearce/jgit/pgm/Die.java (100%)
 rename {org.spearce.jgit => org.spearce.jgit.pgm}/src/org/spearce/jgit/pgm/DiffTree.java (100%)
 rename {org.spearce.jgit => org.spearce.jgit.pgm}/src/org/spearce/jgit/pgm/Fetch.java (100%)
 rename {org.spearce.jgit => org.spearce.jgit.pgm}/src/org/spearce/jgit/pgm/Glog.java (100%)
 rename {org.spearce.jgit => org.spearce.jgit.pgm}/src/org/spearce/jgit/pgm/IndexPack.java (100%)
 rename {org.spearce.jgit => org.spearce.jgit.pgm}/src/org/spearce/jgit/pgm/Log.java (100%)
 rename {org.spearce.jgit => org.spearce.jgit.pgm}/src/org/spearce/jgit/pgm/LsRemote.java (100%)
 rename {org.spearce.jgit => org.spearce.jgit.pgm}/src/org/spearce/jgit/pgm/LsTree.java (100%)
 rename {org.spearce.jgit => org.spearce.jgit.pgm}/src/org/spearce/jgit/pgm/Main.java (100%)
 rename {org.spearce.jgit => org.spearce.jgit.pgm}/src/org/spearce/jgit/pgm/MergeBase.java (100%)
 rename {org.spearce.jgit => org.spearce.jgit.pgm}/src/org/spearce/jgit/pgm/Push.java (100%)
 rename {org.spearce.jgit => org.spearce.jgit.pgm}/src/org/spearce/jgit/pgm/RevList.java (100%)
 rename {org.spearce.jgit => org.spearce.jgit.pgm}/src/org/spearce/jgit/pgm/RevWalkTextBuiltin.java (100%)
 rename {org.spearce.jgit => org.spearce.jgit.pgm}/src/org/spearce/jgit/pgm/ShowRef.java (100%)
 rename {org.spearce.jgit => org.spearce.jgit.pgm}/src/org/spearce/jgit/pgm/Tag.java (100%)
 rename {org.spearce.jgit => org.spearce.jgit.pgm}/src/org/spearce/jgit/pgm/TextBuiltin.java (100%)
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/build/JarLinkUtil.java

diff --git a/jgit.sh b/jgit.sh
index 84927bc..121beec 100755
--- a/jgit.sh
+++ b/jgit.sh
@@ -9,6 +9,8 @@ else
 	jgit_home=`dirname $0`
 	cp="$jgit_home/org.spearce.jgit/bin"
 	cp="$cp:$jgit_home/org.spearce.jgit/lib/jsch-0.1.37.jar"
+	cp="$cp:$jgit_home/org.spearce.jgit.pgm/bin"
+	cp="$cp:$jgit_home/org.spearce.jgit.pgm/lib/args4j-2.0.9.jar"
 	unset jgit_home
 	java_args=
 fi
diff --git a/make_jgit.sh b/make_jgit.sh
index 3889dca..bcb2df0 100755
--- a/make_jgit.sh
+++ b/make_jgit.sh
@@ -1,26 +1,80 @@
 #!/bin/sh
 
-PATH=$JAVA_HOME/bin:$PATH
 O=jgit
+PLUGINS="
+	org.spearce.jgit
+	org.spearce.jgit.pgm
+"
+JARS="
+	org.spearce.jgit/lib/jsch-0.1.37.jar
+	org.spearce.jgit.pgm/lib/args4j-2.0.9.jar
+"
+
+if [ -n "$JAVA_HOME" ]
+then
+	PATH=$JAVA_HOME/bin:$PATH
+fi
+
 T=".temp$$.$O"
+T_MF="$T.MF"
+R=`pwd`
+
+cleanup_bin() {
+	rm -f $T $O+ $T_MF
+	for p in $PLUGINS
+	do
+		rm -rf $p/bin2
+	done
+}
 
+die() {
+	cleanup_bin
+	rm -f $O
+	echo >&2 "$@"
+	exit 1
+}
+
+cleanup_bin
 rm -f $O
-rm -rf $T $O+ org.spearce.jgit/bin2
-cp org.spearce.jgit/lib/jsch-0.1.37.jar $T &&
-mkdir org.spearce.jgit/bin2 &&
-(cd org.spearce.jgit/src &&
- find . -name \*.java -type f |
- xargs javac \
-	-source 1.5 \
-	-target 1.5 \
-	-g \
-	-d ../bin2 \
-	-cp ../lib/jsch-0.1.37.jar) &&
-jar uf $T -C org.spearce.jgit/bin2 . &&
-jar uf $T -C org.spearce.jgit META-INF &&
+
+CLASSPATH=
+for j in $JARS
+do
+	if [ -z "$CLASSPATH" ]
+	then
+		CLASSPATH="$R/$j"
+	else
+		CLASSPATH="$CLASSPATH:$R/$j"
+	fi
+done
+export CLASSPATH
+
+for p in $PLUGINS
+do
+	echo "Entering $p ..."
+	(cd $p/src &&
+	 mkdir ../bin2 &&
+	 find . -name \*.java -type f |
+	 xargs javac \
+		-source 1.5 \
+		-target 1.5 \
+		-g \
+		-d ../bin2) || die "Building $p failed."
+	CLASSPATH="$CLASSPATH:$R/$p/bin2"
+done
+
+echo Manifest-Version: 1.0 >$T_MF &&
+echo Implementation-Title: jgit >>$T_MF &&
+echo Implementation-Version: `git describe HEAD` >>$T_MF &&
+
 sed s/@@use_self@@/1/ jgit.sh >$O+ &&
-cat $T >>$O+ &&
+java org.spearce.jgit.pgm.build.JarLinkUtil \
+	`for p in $JARS   ; do printf %s " -include $p"     ;done` \
+	`for p in $PLUGINS; do printf %s " -include $p/bin2";done` \
+	-file META-INF/MANIFEST.MF=$T_MF \
+	>>$O+ &&
 chmod 555 $O+ &&
 mv $O+ $O &&
-echo "Created $O." &&
-rm -rf $T $O+ org.spearce.jgit/bin2
+echo "Created $O." || die "Creating $O failed."
+
+cleanup_bin
diff --git a/org.spearce.jgit.pgm/.classpath b/org.spearce.jgit.pgm/.classpath
new file mode 100644
index 0000000..cc861d2
--- /dev/null
+++ b/org.spearce.jgit.pgm/.classpath
@@ -0,0 +1,8 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<classpath>
+	<classpathentry kind="src" path="src"/>
+	<classpathentry exported="true" kind="lib" path="lib/args4j-2.0.9.jar" sourcepath="lib/args4j-2.0.9.zip"/>
+	<classpathentry exported="true" kind="con" path="org.eclipse.jdt.launching.JRE_CONTAINER"/>
+	<classpathentry combineaccessrules="false" exported="true" kind="src" path="/org.spearce.jgit"/>
+	<classpathentry kind="output" path="bin"/>
+</classpath>
diff --git a/org.spearce.jgit.pgm/.gitignore b/org.spearce.jgit.pgm/.gitignore
new file mode 100644
index 0000000..5e56e04
--- /dev/null
+++ b/org.spearce.jgit.pgm/.gitignore
@@ -0,0 +1 @@
+/bin
diff --git a/org.spearce.jgit.pgm/.project b/org.spearce.jgit.pgm/.project
new file mode 100644
index 0000000..e642f9e
--- /dev/null
+++ b/org.spearce.jgit.pgm/.project
@@ -0,0 +1,17 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<projectDescription>
+	<name>org.spearce.jgit.pgm</name>
+	<comment></comment>
+	<projects>
+	</projects>
+	<buildSpec>
+		<buildCommand>
+			<name>org.eclipse.jdt.core.javabuilder</name>
+			<arguments>
+			</arguments>
+		</buildCommand>
+	</buildSpec>
+	<natures>
+		<nature>org.eclipse.jdt.core.javanature</nature>
+	</natures>
+</projectDescription>
diff --git a/org.spearce.jgit.pgm/.settings/org.eclipse.core.runtime.prefs b/org.spearce.jgit.pgm/.settings/org.eclipse.core.runtime.prefs
new file mode 100644
index 0000000..cce0568
--- /dev/null
+++ b/org.spearce.jgit.pgm/.settings/org.eclipse.core.runtime.prefs
@@ -0,0 +1,3 @@
+#Mon Mar 24 18:55:50 EDT 2008
+eclipse.preferences.version=1
+line.separator=\n
diff --git a/org.spearce.jgit.pgm/.settings/org.eclipse.jdt.core.prefs b/org.spearce.jgit.pgm/.settings/org.eclipse.jdt.core.prefs
new file mode 100644
index 0000000..a67b954
--- /dev/null
+++ b/org.spearce.jgit.pgm/.settings/org.eclipse.jdt.core.prefs
@@ -0,0 +1,320 @@
+#Sun Feb 03 03:16:45 CET 2008
+eclipse.preferences.version=1
+org.eclipse.jdt.core.compiler.codegen.inlineJsrBytecode=enabled
+org.eclipse.jdt.core.compiler.codegen.targetPlatform=1.5
+org.eclipse.jdt.core.compiler.codegen.unusedLocal=preserve
+org.eclipse.jdt.core.compiler.compliance=1.5
+org.eclipse.jdt.core.compiler.debug.lineNumber=generate
+org.eclipse.jdt.core.compiler.debug.localVariable=generate
+org.eclipse.jdt.core.compiler.debug.sourceFile=generate
+org.eclipse.jdt.core.compiler.doc.comment.support=enabled
+org.eclipse.jdt.core.compiler.problem.annotationSuperInterface=warning
+org.eclipse.jdt.core.compiler.problem.assertIdentifier=error
+org.eclipse.jdt.core.compiler.problem.autoboxing=warning
+org.eclipse.jdt.core.compiler.problem.deprecation=warning
+org.eclipse.jdt.core.compiler.problem.deprecationInDeprecatedCode=disabled
+org.eclipse.jdt.core.compiler.problem.deprecationWhenOverridingDeprecatedMethod=disabled
+org.eclipse.jdt.core.compiler.problem.discouragedReference=warning
+org.eclipse.jdt.core.compiler.problem.emptyStatement=warning
+org.eclipse.jdt.core.compiler.problem.enumIdentifier=error
+org.eclipse.jdt.core.compiler.problem.fallthroughCase=warning
+org.eclipse.jdt.core.compiler.problem.fieldHiding=warning
+org.eclipse.jdt.core.compiler.problem.finalParameterBound=warning
+org.eclipse.jdt.core.compiler.problem.finallyBlockNotCompletingNormally=error
+org.eclipse.jdt.core.compiler.problem.forbiddenReference=error
+org.eclipse.jdt.core.compiler.problem.hiddenCatchBlock=error
+org.eclipse.jdt.core.compiler.problem.incompatibleNonInheritedInterfaceMethod=warning
+org.eclipse.jdt.core.compiler.problem.incompleteEnumSwitch=warning
+org.eclipse.jdt.core.compiler.problem.indirectStaticAccess=error
+org.eclipse.jdt.core.compiler.problem.invalidJavadoc=error
+org.eclipse.jdt.core.compiler.problem.invalidJavadocTags=enabled
+org.eclipse.jdt.core.compiler.problem.invalidJavadocTagsDeprecatedRef=enabled
+org.eclipse.jdt.core.compiler.problem.invalidJavadocTagsNotVisibleRef=enabled
+org.eclipse.jdt.core.compiler.problem.invalidJavadocTagsVisibility=private
+org.eclipse.jdt.core.compiler.problem.localVariableHiding=warning
+org.eclipse.jdt.core.compiler.problem.methodWithConstructorName=error
+org.eclipse.jdt.core.compiler.problem.missingDeprecatedAnnotation=ignore
+org.eclipse.jdt.core.compiler.problem.missingJavadocComments=error
+org.eclipse.jdt.core.compiler.problem.missingJavadocCommentsOverriding=disabled
+org.eclipse.jdt.core.compiler.problem.missingJavadocCommentsVisibility=public
+org.eclipse.jdt.core.compiler.problem.missingJavadocTags=error
+org.eclipse.jdt.core.compiler.problem.missingJavadocTagsOverriding=disabled
+org.eclipse.jdt.core.compiler.problem.missingJavadocTagsVisibility=private
+org.eclipse.jdt.core.compiler.problem.missingOverrideAnnotation=ignore
+org.eclipse.jdt.core.compiler.problem.missingSerialVersion=warning
+org.eclipse.jdt.core.compiler.problem.noEffectAssignment=error
+org.eclipse.jdt.core.compiler.problem.noImplicitStringConversion=error
+org.eclipse.jdt.core.compiler.problem.nonExternalizedStringLiteral=ignore
+org.eclipse.jdt.core.compiler.problem.nullReference=warning
+org.eclipse.jdt.core.compiler.problem.overridingPackageDefaultMethod=warning
+org.eclipse.jdt.core.compiler.problem.parameterAssignment=ignore
+org.eclipse.jdt.core.compiler.problem.possibleAccidentalBooleanAssignment=error
+org.eclipse.jdt.core.compiler.problem.potentialNullReference=warning
+org.eclipse.jdt.core.compiler.problem.rawTypeReference=ignore
+org.eclipse.jdt.core.compiler.problem.redundantNullCheck=warning
+org.eclipse.jdt.core.compiler.problem.specialParameterHidingField=disabled
+org.eclipse.jdt.core.compiler.problem.staticAccessReceiver=error
+org.eclipse.jdt.core.compiler.problem.suppressWarnings=enabled
+org.eclipse.jdt.core.compiler.problem.typeParameterHiding=warning
+org.eclipse.jdt.core.compiler.problem.uncheckedTypeOperation=warning
+org.eclipse.jdt.core.compiler.problem.undocumentedEmptyBlock=warning
+org.eclipse.jdt.core.compiler.problem.unhandledWarningToken=warning
+org.eclipse.jdt.core.compiler.problem.unnecessaryTypeCheck=error
+org.eclipse.jdt.core.compiler.problem.unqualifiedFieldAccess=ignore
+org.eclipse.jdt.core.compiler.problem.unusedDeclaredThrownException=warning
+org.eclipse.jdt.core.compiler.problem.unusedDeclaredThrownExceptionWhenOverriding=disabled
+org.eclipse.jdt.core.compiler.problem.unusedImport=error
+org.eclipse.jdt.core.compiler.problem.unusedLabel=error
+org.eclipse.jdt.core.compiler.problem.unusedLocal=error
+org.eclipse.jdt.core.compiler.problem.unusedParameter=warning
+org.eclipse.jdt.core.compiler.problem.unusedParameterWhenImplementingAbstract=disabled
+org.eclipse.jdt.core.compiler.problem.unusedParameterWhenOverridingConcrete=disabled
+org.eclipse.jdt.core.compiler.problem.unusedPrivateMember=error
+org.eclipse.jdt.core.compiler.problem.varargsArgumentNeedCast=error
+org.eclipse.jdt.core.compiler.source=1.5
+org.eclipse.jdt.core.formatter.align_type_members_on_columns=false
+org.eclipse.jdt.core.formatter.alignment_for_arguments_in_allocation_expression=16
+org.eclipse.jdt.core.formatter.alignment_for_arguments_in_enum_constant=16
+org.eclipse.jdt.core.formatter.alignment_for_arguments_in_explicit_constructor_call=16
+org.eclipse.jdt.core.formatter.alignment_for_arguments_in_method_invocation=16
+org.eclipse.jdt.core.formatter.alignment_for_arguments_in_qualified_allocation_expression=16
+org.eclipse.jdt.core.formatter.alignment_for_assignment=0
+org.eclipse.jdt.core.formatter.alignment_for_binary_expression=16
+org.eclipse.jdt.core.formatter.alignment_for_compact_if=16
+org.eclipse.jdt.core.formatter.alignment_for_conditional_expression=80
+org.eclipse.jdt.core.formatter.alignment_for_enum_constants=0
+org.eclipse.jdt.core.formatter.alignment_for_expressions_in_array_initializer=16
+org.eclipse.jdt.core.formatter.alignment_for_multiple_fields=16
+org.eclipse.jdt.core.formatter.alignment_for_parameters_in_constructor_declaration=16
+org.eclipse.jdt.core.formatter.alignment_for_parameters_in_method_declaration=16
+org.eclipse.jdt.core.formatter.alignment_for_selector_in_method_invocation=16
+org.eclipse.jdt.core.formatter.alignment_for_superclass_in_type_declaration=16
+org.eclipse.jdt.core.formatter.alignment_for_superinterfaces_in_enum_declaration=16
+org.eclipse.jdt.core.formatter.alignment_for_superinterfaces_in_type_declaration=16
+org.eclipse.jdt.core.formatter.alignment_for_throws_clause_in_constructor_declaration=16
+org.eclipse.jdt.core.formatter.alignment_for_throws_clause_in_method_declaration=16
+org.eclipse.jdt.core.formatter.blank_lines_after_imports=1
+org.eclipse.jdt.core.formatter.blank_lines_after_package=1
+org.eclipse.jdt.core.formatter.blank_lines_before_field=1
+org.eclipse.jdt.core.formatter.blank_lines_before_first_class_body_declaration=0
+org.eclipse.jdt.core.formatter.blank_lines_before_imports=1
+org.eclipse.jdt.core.formatter.blank_lines_before_member_type=1
+org.eclipse.jdt.core.formatter.blank_lines_before_method=1
+org.eclipse.jdt.core.formatter.blank_lines_before_new_chunk=1
+org.eclipse.jdt.core.formatter.blank_lines_before_package=0
+org.eclipse.jdt.core.formatter.blank_lines_between_type_declarations=1
+org.eclipse.jdt.core.formatter.brace_position_for_annotation_type_declaration=end_of_line
+org.eclipse.jdt.core.formatter.brace_position_for_anonymous_type_declaration=end_of_line
+org.eclipse.jdt.core.formatter.brace_position_for_array_initializer=end_of_line
+org.eclipse.jdt.core.formatter.brace_position_for_block=end_of_line
+org.eclipse.jdt.core.formatter.brace_position_for_block_in_case=end_of_line
+org.eclipse.jdt.core.formatter.brace_position_for_constructor_declaration=end_of_line
+org.eclipse.jdt.core.formatter.brace_position_for_enum_constant=end_of_line
+org.eclipse.jdt.core.formatter.brace_position_for_enum_declaration=end_of_line
+org.eclipse.jdt.core.formatter.brace_position_for_method_declaration=end_of_line
+org.eclipse.jdt.core.formatter.brace_position_for_switch=end_of_line
+org.eclipse.jdt.core.formatter.brace_position_for_type_declaration=end_of_line
+org.eclipse.jdt.core.formatter.comment.clear_blank_lines=false
+org.eclipse.jdt.core.formatter.comment.format_comments=true
+org.eclipse.jdt.core.formatter.comment.format_header=false
+org.eclipse.jdt.core.formatter.comment.format_html=true
+org.eclipse.jdt.core.formatter.comment.format_source_code=true
+org.eclipse.jdt.core.formatter.comment.indent_parameter_description=true
+org.eclipse.jdt.core.formatter.comment.indent_root_tags=true
+org.eclipse.jdt.core.formatter.comment.insert_new_line_before_root_tags=insert
+org.eclipse.jdt.core.formatter.comment.insert_new_line_for_parameter=insert
+org.eclipse.jdt.core.formatter.comment.line_length=80
+org.eclipse.jdt.core.formatter.compact_else_if=true
+org.eclipse.jdt.core.formatter.continuation_indentation=2
+org.eclipse.jdt.core.formatter.continuation_indentation_for_array_initializer=2
+org.eclipse.jdt.core.formatter.format_guardian_clause_on_one_line=false
+org.eclipse.jdt.core.formatter.indent_body_declarations_compare_to_annotation_declaration_header=true
+org.eclipse.jdt.core.formatter.indent_body_declarations_compare_to_enum_constant_header=true
+org.eclipse.jdt.core.formatter.indent_body_declarations_compare_to_enum_declaration_header=true
+org.eclipse.jdt.core.formatter.indent_body_declarations_compare_to_type_header=true
+org.eclipse.jdt.core.formatter.indent_breaks_compare_to_cases=true
+org.eclipse.jdt.core.formatter.indent_empty_lines=false
+org.eclipse.jdt.core.formatter.indent_statements_compare_to_block=true
+org.eclipse.jdt.core.formatter.indent_statements_compare_to_body=true
+org.eclipse.jdt.core.formatter.indent_switchstatements_compare_to_cases=true
+org.eclipse.jdt.core.formatter.indent_switchstatements_compare_to_switch=false
+org.eclipse.jdt.core.formatter.indentation.size=4
+org.eclipse.jdt.core.formatter.insert_new_line_after_annotation=insert
+org.eclipse.jdt.core.formatter.insert_new_line_after_opening_brace_in_array_initializer=do not insert
+org.eclipse.jdt.core.formatter.insert_new_line_at_end_of_file_if_missing=do not insert
+org.eclipse.jdt.core.formatter.insert_new_line_before_catch_in_try_statement=do not insert
+org.eclipse.jdt.core.formatter.insert_new_line_before_closing_brace_in_array_initializer=do not insert
+org.eclipse.jdt.core.formatter.insert_new_line_before_else_in_if_statement=do not insert
+org.eclipse.jdt.core.formatter.insert_new_line_before_finally_in_try_statement=do not insert
+org.eclipse.jdt.core.formatter.insert_new_line_before_while_in_do_statement=do not insert
+org.eclipse.jdt.core.formatter.insert_new_line_in_empty_annotation_declaration=insert
+org.eclipse.jdt.core.formatter.insert_new_line_in_empty_anonymous_type_declaration=insert
+org.eclipse.jdt.core.formatter.insert_new_line_in_empty_block=insert
+org.eclipse.jdt.core.formatter.insert_new_line_in_empty_enum_constant=insert
+org.eclipse.jdt.core.formatter.insert_new_line_in_empty_enum_declaration=insert
+org.eclipse.jdt.core.formatter.insert_new_line_in_empty_method_body=insert
+org.eclipse.jdt.core.formatter.insert_new_line_in_empty_type_declaration=insert
+org.eclipse.jdt.core.formatter.insert_space_after_and_in_type_parameter=insert
+org.eclipse.jdt.core.formatter.insert_space_after_assignment_operator=insert
+org.eclipse.jdt.core.formatter.insert_space_after_at_in_annotation=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_at_in_annotation_type_declaration=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_binary_operator=insert
+org.eclipse.jdt.core.formatter.insert_space_after_closing_angle_bracket_in_type_arguments=insert
+org.eclipse.jdt.core.formatter.insert_space_after_closing_angle_bracket_in_type_parameters=insert
+org.eclipse.jdt.core.formatter.insert_space_after_closing_brace_in_block=insert
+org.eclipse.jdt.core.formatter.insert_space_after_closing_paren_in_cast=insert
+org.eclipse.jdt.core.formatter.insert_space_after_colon_in_assert=insert
+org.eclipse.jdt.core.formatter.insert_space_after_colon_in_case=insert
+org.eclipse.jdt.core.formatter.insert_space_after_colon_in_conditional=insert
+org.eclipse.jdt.core.formatter.insert_space_after_colon_in_for=insert
+org.eclipse.jdt.core.formatter.insert_space_after_colon_in_labeled_statement=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_allocation_expression=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_annotation=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_array_initializer=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_constructor_declaration_parameters=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_constructor_declaration_throws=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_enum_constant_arguments=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_enum_declarations=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_explicitconstructorcall_arguments=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_for_increments=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_for_inits=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_method_declaration_parameters=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_method_declaration_throws=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_method_invocation_arguments=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_multiple_field_declarations=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_multiple_local_declarations=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_parameterized_type_reference=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_superinterfaces=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_type_arguments=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_type_parameters=insert
+org.eclipse.jdt.core.formatter.insert_space_after_ellipsis=insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_angle_bracket_in_parameterized_type_reference=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_angle_bracket_in_type_arguments=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_angle_bracket_in_type_parameters=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_brace_in_array_initializer=insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_bracket_in_array_allocation_expression=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_bracket_in_array_reference=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_annotation=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_cast=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_catch=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_constructor_declaration=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_enum_constant=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_for=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_if=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_method_declaration=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_method_invocation=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_parenthesized_expression=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_switch=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_synchronized=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_while=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_postfix_operator=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_prefix_operator=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_question_in_conditional=insert
+org.eclipse.jdt.core.formatter.insert_space_after_question_in_wildcard=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_semicolon_in_for=insert
+org.eclipse.jdt.core.formatter.insert_space_after_unary_operator=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_and_in_type_parameter=insert
+org.eclipse.jdt.core.formatter.insert_space_before_assignment_operator=insert
+org.eclipse.jdt.core.formatter.insert_space_before_at_in_annotation_type_declaration=insert
+org.eclipse.jdt.core.formatter.insert_space_before_binary_operator=insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_angle_bracket_in_parameterized_type_reference=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_angle_bracket_in_type_arguments=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_angle_bracket_in_type_parameters=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_brace_in_array_initializer=insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_bracket_in_array_allocation_expression=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_bracket_in_array_reference=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_annotation=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_cast=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_catch=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_constructor_declaration=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_enum_constant=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_for=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_if=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_method_declaration=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_method_invocation=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_parenthesized_expression=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_switch=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_synchronized=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_while=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_colon_in_assert=insert
+org.eclipse.jdt.core.formatter.insert_space_before_colon_in_case=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_colon_in_conditional=insert
+org.eclipse.jdt.core.formatter.insert_space_before_colon_in_default=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_colon_in_for=insert
+org.eclipse.jdt.core.formatter.insert_space_before_colon_in_labeled_statement=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_allocation_expression=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_annotation=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_array_initializer=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_constructor_declaration_parameters=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_constructor_declaration_throws=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_enum_constant_arguments=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_enum_declarations=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_explicitconstructorcall_arguments=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_for_increments=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_for_inits=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_method_declaration_parameters=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_method_declaration_throws=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_method_invocation_arguments=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_multiple_field_declarations=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_multiple_local_declarations=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_parameterized_type_reference=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_superinterfaces=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_type_arguments=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_type_parameters=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_ellipsis=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_angle_bracket_in_parameterized_type_reference=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_angle_bracket_in_type_arguments=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_angle_bracket_in_type_parameters=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_annotation_type_declaration=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_anonymous_type_declaration=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_array_initializer=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_block=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_constructor_declaration=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_enum_constant=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_enum_declaration=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_method_declaration=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_switch=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_type_declaration=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_bracket_in_array_allocation_expression=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_bracket_in_array_reference=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_bracket_in_array_type_reference=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_annotation=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_annotation_type_member_declaration=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_catch=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_constructor_declaration=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_enum_constant=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_for=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_if=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_method_declaration=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_method_invocation=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_parenthesized_expression=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_switch=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_synchronized=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_while=insert
+org.eclipse.jdt.core.formatter.insert_space_before_parenthesized_expression_in_return=insert
+org.eclipse.jdt.core.formatter.insert_space_before_postfix_operator=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_prefix_operator=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_question_in_conditional=insert
+org.eclipse.jdt.core.formatter.insert_space_before_question_in_wildcard=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_semicolon=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_semicolon_in_for=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_unary_operator=do not insert
+org.eclipse.jdt.core.formatter.insert_space_between_brackets_in_array_type_reference=do not insert
+org.eclipse.jdt.core.formatter.insert_space_between_empty_braces_in_array_initializer=do not insert
+org.eclipse.jdt.core.formatter.insert_space_between_empty_brackets_in_array_allocation_expression=do not insert
+org.eclipse.jdt.core.formatter.insert_space_between_empty_parens_in_annotation_type_member_declaration=do not insert
+org.eclipse.jdt.core.formatter.insert_space_between_empty_parens_in_constructor_declaration=do not insert
+org.eclipse.jdt.core.formatter.insert_space_between_empty_parens_in_enum_constant=do not insert
+org.eclipse.jdt.core.formatter.insert_space_between_empty_parens_in_method_declaration=do not insert
+org.eclipse.jdt.core.formatter.insert_space_between_empty_parens_in_method_invocation=do not insert
+org.eclipse.jdt.core.formatter.keep_else_statement_on_same_line=false
+org.eclipse.jdt.core.formatter.keep_empty_array_initializer_on_one_line=false
+org.eclipse.jdt.core.formatter.keep_imple_if_on_one_line=false
+org.eclipse.jdt.core.formatter.keep_then_statement_on_same_line=false
+org.eclipse.jdt.core.formatter.lineSplit=80
+org.eclipse.jdt.core.formatter.number_of_blank_lines_at_beginning_of_method_body=0
+org.eclipse.jdt.core.formatter.number_of_empty_lines_to_preserve=1
+org.eclipse.jdt.core.formatter.put_empty_statement_on_new_line=true
+org.eclipse.jdt.core.formatter.tabulation.char=tab
+org.eclipse.jdt.core.formatter.tabulation.size=4
+org.eclipse.jdt.core.formatter.use_tabs_only_for_leading_indentations=false
diff --git a/org.spearce.jgit.pgm/.settings/org.eclipse.jdt.ui.prefs b/org.spearce.jgit.pgm/.settings/org.eclipse.jdt.ui.prefs
new file mode 100644
index 0000000..709a440
--- /dev/null
+++ b/org.spearce.jgit.pgm/.settings/org.eclipse.jdt.ui.prefs
@@ -0,0 +1,9 @@
+#Wed May 09 00:20:24 CEST 2007
+eclipse.preferences.version=1
+formatter_profile=_JGit
+formatter_settings_version=10
+org.eclipse.jdt.ui.ignorelowercasenames=true
+org.eclipse.jdt.ui.importorder=java;javax;org;com;
+org.eclipse.jdt.ui.ondemandthreshold=99
+org.eclipse.jdt.ui.staticondemandthreshold=99
+org.eclipse.jdt.ui.text.custom_code_templates=<?xml version\="1.0" encoding\="UTF-8"?><templates/>
diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/Die.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Die.java
similarity index 100%
rename from org.spearce.jgit/src/org/spearce/jgit/pgm/Die.java
rename to org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Die.java
diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/DiffTree.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/DiffTree.java
similarity index 100%
rename from org.spearce.jgit/src/org/spearce/jgit/pgm/DiffTree.java
rename to org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/DiffTree.java
diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/Fetch.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
similarity index 100%
rename from org.spearce.jgit/src/org/spearce/jgit/pgm/Fetch.java
rename to org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/Glog.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Glog.java
similarity index 100%
rename from org.spearce.jgit/src/org/spearce/jgit/pgm/Glog.java
rename to org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Glog.java
diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/IndexPack.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/IndexPack.java
similarity index 100%
rename from org.spearce.jgit/src/org/spearce/jgit/pgm/IndexPack.java
rename to org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/IndexPack.java
diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/Log.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Log.java
similarity index 100%
rename from org.spearce.jgit/src/org/spearce/jgit/pgm/Log.java
rename to org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Log.java
diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/LsRemote.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/LsRemote.java
similarity index 100%
rename from org.spearce.jgit/src/org/spearce/jgit/pgm/LsRemote.java
rename to org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/LsRemote.java
diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/LsTree.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/LsTree.java
similarity index 100%
rename from org.spearce.jgit/src/org/spearce/jgit/pgm/LsTree.java
rename to org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/LsTree.java
diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/Main.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Main.java
similarity index 100%
rename from org.spearce.jgit/src/org/spearce/jgit/pgm/Main.java
rename to org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Main.java
diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/MergeBase.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/MergeBase.java
similarity index 100%
rename from org.spearce.jgit/src/org/spearce/jgit/pgm/MergeBase.java
rename to org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/MergeBase.java
diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/Push.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
similarity index 100%
rename from org.spearce.jgit/src/org/spearce/jgit/pgm/Push.java
rename to org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/RevList.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RevList.java
similarity index 100%
rename from org.spearce.jgit/src/org/spearce/jgit/pgm/RevList.java
rename to org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RevList.java
diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/RevWalkTextBuiltin.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RevWalkTextBuiltin.java
similarity index 100%
rename from org.spearce.jgit/src/org/spearce/jgit/pgm/RevWalkTextBuiltin.java
rename to org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RevWalkTextBuiltin.java
diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/ShowRef.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/ShowRef.java
similarity index 100%
rename from org.spearce.jgit/src/org/spearce/jgit/pgm/ShowRef.java
rename to org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/ShowRef.java
diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/Tag.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Tag.java
similarity index 100%
rename from org.spearce.jgit/src/org/spearce/jgit/pgm/Tag.java
rename to org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Tag.java
diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/TextBuiltin.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
similarity index 100%
rename from org.spearce.jgit/src/org/spearce/jgit/pgm/TextBuiltin.java
rename to org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/build/JarLinkUtil.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/build/JarLinkUtil.java
new file mode 100644
index 0000000..06827bf
--- /dev/null
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/build/JarLinkUtil.java
@@ -0,0 +1,204 @@
+/*
+ * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.pgm.build;
+
+import java.io.File;
+import java.io.FileInputStream;
+import java.io.IOException;
+import java.io.InputStream;
+import java.util.ArrayList;
+import java.util.Enumeration;
+import java.util.HashMap;
+import java.util.List;
+import java.util.Map;
+import java.util.zip.ZipEntry;
+import java.util.zip.ZipFile;
+import java.util.zip.ZipOutputStream;
+
+import org.kohsuke.args4j.CmdLineException;
+import org.kohsuke.args4j.CmdLineParser;
+import org.kohsuke.args4j.Option;
+import org.kohsuke.args4j.spi.MapOptionHandler;
+
+/**
+ * Combines multiple JAR and directory sources into a single JAR file.
+ * <p>
+ * This is a crude command line utility to combine multiple JAR files into a
+ * single JAR file, without first needing to unpack the individual JARs.
+ * <p>
+ * The output ZIP stream is sent to standard out and can be redirected onto the
+ * end of a shell script which starts the JRE.
+ */
+public class JarLinkUtil {
+	/**
+	 * Combine multiple JARs.
+	 * 
+	 * @param argv
+	 *            the command line arguments indicating the files to pack.
+	 * @throws IOException
+	 *             a source file could not be read.
+	 */
+	public static void main(final String[] argv) throws IOException {
+		final JarLinkUtil util = new JarLinkUtil();
+		final CmdLineParser clp = new CmdLineParser(util);
+		try {
+			clp.parseArgument(argv);
+		} catch (CmdLineException e) {
+			clp.printSingleLineUsage(System.err);
+			System.exit(1);
+		}
+		util.run();
+	}
+
+	@Option(name = "-include", required = true)
+	private List<File> includes = new ArrayList<File>();
+
+	@Option(name = "-file", handler = MapOptionHandler.class)
+	private Map<String, String> files = new HashMap<String, String>();
+
+	private final Map<String, File> chosenSources = new HashMap<String, File>();
+
+	private ZipOutputStream zos;
+
+	private JarLinkUtil() {
+		// Command line utility only.
+	}
+
+	private void run() throws IOException {
+		for (final File src : includes) {
+			if (src.isFile())
+				scanJar(src);
+			else
+				scanDirectory(src, src, "");
+		}
+		for (final Map.Entry<String, String> e : files.entrySet())
+			chosenSources.put(e.getKey(), new File(e.getValue()));
+
+		zos = new ZipOutputStream(System.out);
+		zos.setLevel(9);
+
+		for (final File src : includes) {
+			if (src.isFile())
+				appendJar(src);
+			else
+				appendDirectory(src, src, "");
+		}
+		for (final String name : files.keySet())
+			appendFile(chosenSources.get(name), name);
+
+		zos.close();
+	}
+
+	private void scanJar(final File jarPath) throws IOException {
+		final ZipFile zf = new ZipFile(jarPath);
+		final Enumeration<? extends ZipEntry> e = zf.entries();
+		while (e.hasMoreElements())
+			chosenSources.put(e.nextElement().getName(), jarPath);
+		zf.close();
+	}
+
+	private void scanDirectory(final File rootPath, final File dirPath,
+			final String pfx) throws IOException {
+		final File[] entries = dirPath.listFiles();
+		if (entries == null)
+			return;
+		for (final File e : entries) {
+			if (e.getName().equals(".") || e.getName().equals(".."))
+				continue;
+
+			if (e.isDirectory())
+				scanDirectory(rootPath, e, pfx + e.getName() + "/");
+			else
+				chosenSources.put(pfx + e.getName(), rootPath);
+		}
+	}
+
+	private void appendJar(final File jarPath) throws IOException {
+		final ZipFile zf = new ZipFile(jarPath);
+		final Enumeration<? extends ZipEntry> e = zf.entries();
+		while (e.hasMoreElements()) {
+			final ZipEntry ze = e.nextElement();
+			final String name = ze.getName();
+			if (chosenSources.get(name) == jarPath)
+				appendEntry(name, ze.getSize(), ze.getTime(), zf
+						.getInputStream(ze));
+		}
+		zf.close();
+	}
+
+	private void appendDirectory(final File rootDir, final File dirPath,
+			final String pfx) throws IOException {
+		final File[] entries = dirPath.listFiles();
+		if (entries == null)
+			return;
+		for (final File e : entries) {
+			if (e.getName().equals(".") || e.getName().equals(".."))
+				continue;
+
+			if (e.isDirectory())
+				appendDirectory(rootDir, e, pfx + e.getName() + "/");
+			else if (chosenSources.get(pfx + e.getName()) == rootDir)
+				appendFile(e, pfx + e.getName());
+		}
+	}
+
+	private void appendFile(final File path, final String name)
+			throws IOException {
+		final long len = path.length();
+		final long time = path.lastModified();
+		final InputStream is = new FileInputStream(path);
+		appendEntry(name, len, time, is);
+	}
+
+	private void appendEntry(final String name, final long len,
+			final long time, final InputStream is) throws IOException {
+		final ZipEntry ze = new ZipEntry(name);
+		ze.setSize(len);
+		ze.setTime(time);
+		zos.putNextEntry(ze);
+		try {
+			final byte[] buf = new byte[4096];
+			int n;
+			while ((n = is.read(buf)) >= 0)
+				zos.write(buf, 0, n);
+		} finally {
+			is.close();
+		}
+		zos.closeEntry();
+	}
+}
-- 
1.5.6.3.569.ga9185
